# frozen_string_literal: true

require "active_support/all"
require "email_address"
require "time"
require "uri"

module SBOM
  module CycloneDX
    module SchemaObject
      def self.build(name, *member_names, &block)
        klass = Class.new(Base)

        klass.define_singleton_method(:name) { name }
        klass.define_singleton_method(:members) { member_names }
        klass.define_method(:members) { member_names }
        klass.const_set(:ValueObject, Struct.new(*member_names, keyword_init: true))

        klass.instance_exec(&block) unless block.nil?

        klass.define_method(:initialize) do |**properties|
          # @type var errors: Hash[Symbol, Array[String]]
          errors = {}

          resolved_props = defaults.merge(
            properties.to_h do |prop_name, value|
              value = cast(prop_name, value)
              value_errors = validate(prop_name, value)
              errors[prop_name] = value_errors if value_errors.present?

              [prop_name, value]
            end
          )

          @values = ValueObject.new(**resolved_props)

          required = self.class.members.select { |m| required?(m) }
          missing_props = required - resolved_props.keys
          errors[:base] = ["missing required properties: #{missing_props.join(", ")}"] if missing_props.any?
          raise ArgumentError, "Validation failed: #{format_errors(errors)}" if errors.any?
        end

        klass.send(:freeze_definition!)
        klass
      end

      module ClassMethods # rubocop:disable Metrics/ModuleLength
        def json_alias(name, json_alias)
          add_member_property(name, :json_alias, json_alias)
        end

        def const(name, value)
          add_member_property(name, :const, true)
          add_member_property(name, :default, value)
        end

        def default(name, to)
          add_member_property(name, :default, to)
        end

        def cast(name = nil, to:, items: nil) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
          cast_proc =
            case to
            when :integer
              ->(value) { value.presence && Integer(value) }
            when :float
              ->(value) { value.presence && Float(value) }
            when :string
              ->(value) { value.presence && value.to_s }
            when :bool
              lambda { |value|
                next nil if value.nil?
                next true if value == true || value.casecmp?("true")
                next false if value == false || value.casecmp?("false")

                raise(ArgumentError, "Invalid boolean value: #{value}")
              }
            when :datetime
              ->(value) { value.presence && DateTime.iso8601(value) }
            when :uri
              ->(value) { value.presence && URI.parse(value) }
            when :email_address
              ->(value) { value.presence && EmailAddress.new(value) }
            when :array
              ->(value) { value.presence && value.map(&items) }
            when :set
              ->(value) { value.presence && Set.new(value.map(&items)) }
            when :one_of
              raise NotImplementedError, "Union types are not yet supported"
            when ::Class
              raise ArgumentError, "Class must include SchemaObject::Base" unless to < Base

              ->(value) { value.presence && to.new(**value) }
            else
              raise ArgumentError, "Unknown cast type: #{to}"
            end

          return cast_proc if name.nil?

          add_member_property(name, :typecast, cast_proc)
        end

        def required(name, condition = true) # rubocop:disable Style/OptionalBooleanParameter
          add_member_property(name, :required, condition)
        end

        def validate(name, **validations) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
          raise ArgumentError, "Must provide at least one validation" if validations.empty?

          validators = validations.map do |key, value|
            case key
            when :maximum
              raise ArgumentError, "Value must be an Integer or Float" unless value.is_a?(Integer) || value.is_a?(Float)

              Validator.maximum(value)
            when :minimum
              raise ArgumentError, "Value must be an Integer or Float" unless value.is_a?(Integer) || value.is_a?(Float)

              Validator.minimum(value)
            when :max_length
              raise ArgumentError, "Value must be an Integer >= 0" unless value.is_a?(Integer) && value >= 0

              Validator.max_length(value)
            when :min_length
              raise ArgumentError, "Value must be an Integer >= 0" unless value.is_a?(Integer) && value >= 0

              Validator.min_length(value)
            when :pattern
              raise ArgumentError, "Value must be a Regexp" unless value.is_a?(Regexp)

              Validator.pattern(value)
            when :enum
              raise ArgumentError, "Value must be an Array of Strings" unless value.is_a?(Array) && value.all?(String)

              Validator.enum(value)
            when :valid
              raise ArgumentError, "Value must be a Proc with 1 arg" unless value.is_a?(Proc) && value.arity == 1

              Validator.new("is invalid", &value)
            end
          end

          add_member_property(name, :validations, validators)
        end

        def members_definitions
          @members_definitions
        end

        private

        def freeze_definition! # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity
          raise ArgumentError, "Attempted to freeze already frozen definition" if @members_definitions

          # @type var default_validations: Array[Validator]
          default_validations = []
          # @type var default_typecast: ^(castableFieldValue) -> fieldValue
          default_typecast = lambda do |value|
            case value
            when Integer, Float, String, TrueClass, FalseClass, DateTime, URI, EmailAddress, ClassMethods
              value
            when Array, Set
              value.map { |v| default_typecast.call(v) }
            else
              raise ArgumentError, "Cannot cast value: #{value.inspect}"
            end
          end

          @members_definitions = @members_properties.to_h do |name, props|
            [
              name,
              MemberDefinition.new(
                json_alias: props.fetch(:json_alias, name.to_s.camelize(:lower)),
                const: props.fetch(:const, false),
                default: props[:default],
                required: props.fetch(:required, false),
                typecast: props.fetch(:typecast, default_typecast),
                validations: props.fetch(:validations, default_validations)
              )
            ]
          end.freeze

          @members_definitions.each do |member_name, member_def|
            if member_def.const
              undef_method(:"#{member_name}=")
              next
            end

            alias_method :"raw_#{member_name}=", :"#{member_name}="
            define_method(:"#{member_name}=") do |value|
              key = __method__.to_s.delete_suffix("=").to_sym
              cast_value = public_send(:cast_and_validate, key, value)
              public_send(:"raw_#{member_name}=", cast_value)
            end
          end
        end

        def add_member_property(name, arg_name, arg_value)
          @members_properties ||= members.to_h do |member|
            # @type var default_property: memberProperty[fieldValue]
            default_property = {}
            [member, default_property]
          end
          member_props = @members_properties.fetch(name) { raise ArgumentError, "Unknown member: #{name}" }
          raise ArgumentError, "Property #{name} already has a value for #{arg_name}" if member_props.key?(arg_name)

          member_props[arg_name] = arg_value
        end
      end

      class Base
        extend ClassMethods

        JSON_ALIAS = ""

        def initialize(**properties)
          raise NotImplementedError, "This method should be overridden by the class"
        end

        private

        def cast_and_validate(name, value)
          value = cast(name, value)
          validate!(name, value)
          value
        end

        def defaults
          return @defaults if @defaults.present?

          defaults_array = self.class.members_definitions.flat_map do |name, props|
            next if props.default.nil?
            next [name, props.default.call] if props.default.is_a?(Proc)

            [name, props.default]
          end
          @defaults = defaults_array.to_h
        end

        def required?(name)
          required = self.class.members_definitions[name].required
          return required.call(self) if required.is_a?(Proc)

          required
        end

        def cast(name, value)
          # The current assumption is that if a literal nil is passed, we want to use the default value if present.
          return defaults[name] if value.nil?

          self.class.members_definitions.fetch(name).typecast.call(value)
        end

        def validate(name, value)
          return ["cannot be set because it is a constant"] if self.class.members_definitions[name].const
          return ["is required"] if value.nil? && required?(name)

          # If we are given a proc, we resolve it with the current state of the object before passing it to the type
          self.class.members_definitions.fetch(name).validations.filter_map do |validator|
            validator.validate(value)
          end
        end

        def validate!(name, value)
          errors = validate(name, value)
          raise ArgumentError, "Validation failed: #{format_errors({ name => errors })}" if errors.present?
        end

        def format_errors(errors)
          errors.map { |name, attr_errors| [name, attr_errors.join(", ")].compact.join(" ") }.join("\n")
        end
      end

      class Validator
        def initialize(message = nil, &block)
          @message = message || "is invalid"
          @block = block
        end

        def validate(value)
          return nil if valid?(value)

          @message
        end

        def valid?(value)
          @block.call(value)
        end

        def self.maximum(value)
          new("must be less than or equal to #{value}") { |v| v <= value }
        end

        def self.minimum(value)
          new("must be greater than or equal to #{value}") { |v| v >= value }
        end

        def self.max_length(value)
          new("must be less than or equal to #{value} characters") { |v| v.length <= value }
        end

        def self.min_length(value)
          new("must be greater than or equal to #{value} characters") { |v| v.length >= value }
        end

        def self.pattern(value)
          new("does not match the pattern") { |v| (v.is_a?(String) && v.match?(value)) || true }
        end

        def self.enum(value)
          new("must be one of #{value.join(", ")}") { |v| value.include?(v) }
        end
      end

      MemberDefinition = Data.define(
        :json_alias,
        :const,
        :required,
        :typecast,
        :validations,
        :default
      )
    end
  end
end
