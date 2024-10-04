# frozen_string_literal: true
# rbs_inline: enabled

require "active_support/all"
require "date"
require "json"
require "uri"

module SBOM
  module CycloneDX
    module SchemaObject
      class << self
        def build(name, json_name: nil, &block)
          KlassBuilder.new(name, json_name: json_name).build!(&block)
        end
      end

      class KlassBuilder
        attr_reader :name, :json_name, :props, :consts, :required

        def initialize(name, json_name: nil)
          @name = name
          @json_name = json_name || name.to_s.camelize(:lower)
          @props = {}
          @consts = []
          @required = []
        end

        def const(name, value)
          prop(name, value.class, default: value, const: true)
        end

        def prop(name, type, const: false, json_name: nil, required: false, **validations) # rubocop:disable Metrics/ParameterLists
          type = Type.from(type)
          has_default = validations.key?(:default)

          raise "Default value must be provided for constant property" if const && !has_default

          @props[name] = { type: type, json_name: json_name || name.to_s.underscore, validations: validations }
          @required << name if required
          @consts << name if const

          if has_default
            default_value = type.cast(validations.delete(:default))
            errors = type.validate(default_value, validations)
            raise ArgumentError, "Invalid default value for #{name}: #{errors.join(", ")}" if errors.any?

            @props[name][:default] = default_value if has_default
          end

          nil
        end

        def build!(&block)
          instance_exec(&block)
          @props.freeze
          @consts.freeze
          @required.freeze

          # We include consts here because we want Ruby's Struct internals to treat them as regular members, but we
          # handle attempts to set them by overriding the initializer and []= method, and by removing the setters.
          schema_object = Struct.new(name, *props.keys, keyword_init: true)
          define_consts(schema_object)
          schema_object.include(InstanceMethods)
          define_setters(schema_object)
          schema_object
        end

        private

        def define_consts(schema_object)
          schema_object.set_const(:JSON_NAME, json_name)
          schema_object.set_const(:REQUIRED, required)

          schema_object.set_const(:PROPS, props)
          schema_object.private_constant :PROPS
          schema_object.set_const(:CONSTS, consts)
          schema_object.private_constant :CONSTS
        end

        def define_setters(schema_object)
          props.except(*consts).each_key do |key|
            schema_object.define_method(:"#{key}=") do |value|
              setter(__method__.to_s.delete_suffix("=").to_sym, value) { |val| super(val) }
            end
          end

          consts.each_key { |key| schema_object.undefine_method(:"#{key}=") }
        end
      end
      private_constant :KlassBuilder

      class InstanceMethods
        def initialize(**properties)
          errors = {}

          resolved_props = defaults.merge(
            properties.each_with_object({}) do |name, value|
              value = cast(name, value)
              value_errors = validate(name, value)
              errors[name] = value_errors if value_errors.present?

              [name, value]
            end
          )

          missing_props = REQUIRED - resolved_props.keys
          errors[self.class.name] = "missing required properties: #{missing_props.join(", ")}" if missing_props.any?
          raise ArgumentError, "Validation failed: #{format_errors(errors)}" if errors.any?

          super(**resolved_props)
        end

        def []=(key, value)
          setter(key, value) { |val| super(key, val) }
        end

        private

        def setter(name, value)
          value = cast(name, value)
          validate!(name, value)

          yield(value)
        end

        def defaults
          @defaults ||= PROPS.each_with_object({}) do |(name, prop), memo|
            memo[name] = prop.fetch(:default) if prop.key?(:default)
          end
        end

        def cast(name, value)
          # The current assumption is that if a literal nil is passed, we want to use the default value if present.
          return defaults[name] if value.nil?

          PROPS.dig(name, :type).cast(value)
        end

        def validate(name, value)
          return ["cannot be set because it is a constant"] if CONSTS.include?(name)
          return ["is required"] if value.nil? && REQUIRED.include?(name)

          # If we are given a proc, we resolve it with the current state of the object before passing it to the type
          resolved_validators = PROPS.dig(name, :validations).to_h do |v_name, v_val|
            next [v_name, v_val] unless v_val.is_a?(Proc)
            next [v_name, instance_exec(value, &v_val)] if v_val.arity == 1

            [v_name, instance_exec(&v_val)]
          end

          PROPS.dig(name, :type).validate(value, resolved_validators)
        end

        def validate!(name, value)
          errors = validate(name, value)
          raise ArgumentError, "Validation failed: #{format_errors(errors)}" if errors.present?
        end

        def format_errors(errors)
          errors.map { |name, error| [name, error].compact.join(" ") }.join("\n")
        end
      end
      private_constant :InstanceMethods

      module Type
        STATIC_TYPES = {
          ::Integer => Simple.for(::Integer, extra_attrs: %i[maximum minimum]),
          ::Float => Simple.for(::Float, extra_attrs: %i[maximum minimum]),
          ::String => Simple.for(::String, extra_attrs: %i[enum max_length min_length pattern]),
          :bool => Union.for(Simple.for(::TrueClas), Simple.for(::FalseClass)),
          ::DateTime => Simple.for(::DateTime),
          ::EmailAddress => Simple.for(::EmailAddress),
          ::NilClass => Simple.for(::NilClass),
          ::URI => Simple.for(::URI)
        }.freeze

        def self.from(type)
          return type if type < Base
          return STATIC_TYPES[type] if STATIC_TYPES.key?(type)
          return Union.for(*type[:one_of].map { |t| from(t) }) if type.is_a?(Hash) && type.key?(:one_of)
          return Simple.for(type) if type < Struct && type < SBOM::CycloneDX::SchemaObject::ClassMethods

          if Collection::ALLOWED_INNER_TYPES.include?(type.class) && type.length == 1
            return Collection.for(type.class, from(type.first))
          end

          raise "Invalid type: #{type}"
        end

        class Base
          BASE_ATTRIBUTES = %i[const default json_name required validate].freeze
          ALLOWED_INNER_TYPES = [
            ::NilClass,
            ::Integer,
            ::Float,
            ::String,
            ::TrueClass,
            ::FalseClass,
            ::DateTime,
            ::URI,
            ::EmailAddress,
            ::Array,
            ::Set,
            ::Struct
          ].freeze

          class << self
            # Base type should not be usied directly, and children should implement their own `cast`
            def cast(value)
              raise NotImplementedError
            end

            def validate(value, params)
              return [] if value.nil? || params.fetch(:validate, true)

              ["is not valid"]
            end
          end

          private

          def initialize
            raise NotImplementedError
          end
        end

        class Simple < Base
          ALLOWED_INNER_TYPES = [
            ::NilClass,
            ::Integer,
            ::Float,
            ::String,
            ::DateTime,
            ::URI,
            ::EmailAddress,
            ::Struct,
            ::TrueClass,
            ::FalseClass
          ].freeze

          class << self
            def for(type, extra_attrs: [])
              raise "Invalid type: #{type}" unless ALLOWED_INNER_TYPES.any? { |allowed_type| type <= allowed_type }
              raise "Invalid type: #{type}" if type < Struct && !type < SBOM::CycloneDX::SchemaObject::ClassMethods

              Class.new(self) do
                const_set(:INNER_TYPE, type)
                const_set(:ATTRIBUTES, (BASE_ATTRIBUTES + extra_attrs).uniq)
              end
            end

            def cast(value)
              return value if value <= INNER_TYPE

              return nil if INNER_TYPE == ::NilClass && value.nil?
              return Integer(value) if INNER_TYPE == ::Integer
              return Float(value) if INNER_TYPE == ::Float
              return value.to_s if INNER_TYPE == ::String
              return DateTime.iso8601(value) if INNER_TYPE == ::DateTime
              return URI.parse(value) if INNER_TYPE == ::URI
              return EmailAddress.new(value) if INNER_TYPE == ::EmailAddress
              return INNER_TYPE.new(**value) if INNER_TYPE < ::Struct && (value.keys - INNER_TYPE.members).empty?
              return true if INNER_TYPE == ::TrueClass && value.casecmp?("true")
              return false if INNER_TYPE == ::FalseClass && value.casecmp?("false")

              raise "Invalid value: #{value} for type #{INNER_TYPE.name}"
            end

            def validate(value, params)
              errors =
                case value
                when Numeric then validate_numeric(value, **params.slice(:maximum, :minimum))
                when String then validate_string(value, **params.slice(:enum, :max_length, :min_length, :pattern))
                else []
                end
              errors + super(value, params)
            end

            private

            def validate_numeric(value, maximum: Float::INFINITY, minimum: -Float::INFINITY)
              errors = []
              errors << "must be greater than or equal to #{minimum}" if value < minimum
              errors << "must be less than or equal to #{maximum}" if value > maximum
              errors
            end

            def validate_string(value, enum: nil, max_length: Float::INFINITY, min_length: 0, pattern: //)
              errors = []
              errors << "must be one of: #{enum.join(", ")}" if enum&.exclude?(value)
              errors << "must be at most #{max_length} characters long" if value.length > max_length
              errors << "must be at least #{min_length} characters long" if value.length < min_length
              errors << "must match the pattern: #{pattern}" unless pattern.match?(value)
              errors
            end
          end
        end

        class Union < Base
          class << self
            def for(*types, extra_attrs: [])
              raise "Invalid type: #{type}" unless types.all? do |type|
                ALLOWED_INNER_TYPES.include?(type) || type < Base
              end

              Class.new(self) do
                const_set(:INNER_TYPES, types)
                const_set(:ATTRIBUTES, (BASE_ATTRIBUTES + extra_attrs).uniq)
              end
            end

            # TODO: Try casting from most-specific to least-specific type in the union
            def cast(value)
              INNER_TYPES.each do |type|
                type.cast(value)
              rescue StandardError
                # We ignore the error and continue to the next type
              end

              raise "Invalid value: #{value} for type #{INNER_TYPES.map(&:name).join(" | ")}"
            end

            def validate(value, params)
              Type.from(value.class).validate(value, params) + super(value, params)
            end
          end
        end

        class Collection < Base
          ALLOWED_INNER_TYPES = [::Array, ::Set].freeze
          ATTRIBUTES = BASE_ATTRIBUTES + %i[all min_items max_items].freeze

          def self.for(type, item_type)
            raise "Invalid type: #{type}" unless ALLOWED_INNER_TYPES.include?(type) || type < Base

            Class.new(self) do
              const_set(:INNER_TYPE, type)
              const_set(:ITEM_TYPE, item_type)
            end
          end

          def cast(value)
            return [] if value.nil? || value.empty?

            value = Array[value]
            value = Set.new(value) if INNER_TYPE == ::Set

            value.map { |item| ITEM_TYPE.cast(item) }
          end
        end
      end
      private_constant :Type
    end
  end
end
