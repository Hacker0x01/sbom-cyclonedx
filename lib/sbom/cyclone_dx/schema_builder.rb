# frozen_string_literal: true
# rbs_inline: enabled

require "active_support/all"
require "date"
require "json"
require "uri"

module SBOM
  module CycloneDX
    module SchemaBuilder
      SchemaDefinition = Struct.new(
        :name,
        :json_alias,
        :member_names
      )

      MemberDefinition = Data.define(
        :json_alias,
        :const,
        :required,
        :validations,
        :default
      )

      class << self
        def build(name, *member_names, json_alias: nil, &block)
          schema = SchemaDefinition.new(
            name,
            json_alias || name.to_s.camelize(:lower),
            member_names
          )
          result = KlassBuilder.new(member_names, &block)
          build_klass(schema, result)
        end

        private

        def build_klass(schema, klass_builder_result)
          member_defs = schema.member_names.to_h do |member_name|
            [member_name, klass_builder_result[member_name]]
          end

          Struct.new(schema.name, member_defs.keys).tap do |klass|
            klass.const_set(:JSON_ALIAS, schema.json_alias)
            klass.const_set(:MEMBER_DEFS, member_defs.freeze)
            klass.private_constant :MEMBER_DEFS
            klass.include(SchemaObject)
          end
        end
      end

      class KlassBuilder
        def initialize(member_names, &block)
          @members = member_names.to_h { |member_name| [member_name, nil] }
          @properties = @members.dup
          instance_exec(&block)
        end

        def [](name)
          raise ArgumentError, "Unknown member: #{name}" unless @members.key?(name)

          rv = @members.fetch(name)
          return rv if rv.present?

          member_properties = {
            const: false,
            required: false,
            validations: {}
          }.merge(@properties.fetch(name))

          @members[name] = MemberDefinition.new(**member_properties)
        end

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

        def required(name)
          add_member_property(name, :required, true)
        end

        def validate(name, **validations)
          add_member_property(name, :validations, validations.freeze)
        end

        private

        def property(name)
          return @properties.fetch(name) if @properties.key?(name)

          raise ArgumentError, "Unknown member: #{name}" unless @members.key?(name)

          @properties[name] = {}
        end

        def add_member_property(name, arg_name, arg_value)
          prop = property(name)
          raise ArgumentError, "Property #{name} already has a value for #{arg_name}" if prop.key?(arg_name)

          prop[arg_name] = arg_value
        end
      end
      private_constant :KlassBuilder

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
          BASE_ATTRIBUTES = %i[const default json_alias required validate].freeze
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
              raise "Invalid type: #{types}" unless types.all? do |type|
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

          def self.cast(value)
            return [] if value.nil? || value.empty?

            value = Array[value]
            value = Set.new(value) if INNER_TYPE == ::Set

            value.map { |item| ITEM_TYPE.cast(item) }
          end

          def self.validate(value, params)
            value.map { |item| ITEM_TYPE.validate(item, params) }.flatten + super(value, params)
          end
        end
      end
      private_constant :Type
    end
  end
end
