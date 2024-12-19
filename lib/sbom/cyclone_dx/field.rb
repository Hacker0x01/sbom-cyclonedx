# frozen_string_literal: true

require_relative "validator/array_validator"
require_relative "validator/boolean_validator"
require_relative "validator/date_time_validator"
require_relative "validator/email_address_validator"
require_relative "validator/float_validator"
require_relative "validator/integer_validator"
require_relative "validator/record_validator"
require_relative "validator/string_validator"
require_relative "validator/union_validator"
require_relative "validator/uri_validator"
require_relative "pattern"

module SBOM
  module CycloneDX
    module Field # rubocop:disable Metrics/ModuleLength
      class Base
        attr_reader :errors, :value

        def initialize
          raise "Cannot instantiate abstract Field"
        end

        def value?
          @value.nil?
        end

        def valid?
          @errors = validator.validate(value)
          @errors.empty?
        end

        %i[
          field_name
          validator
          json_name
          required?
          const?
          const
          default?
          default
        ].each { |m| define_method(m) { self.class.public_send(m) } }

        class << self
          attr_reader :field_name, :validator, :json_name, :const

          def required?
            validator.required?
          end

          def const?
            @const_present
          end

          def default
            # Skip type-checking here because it is already checked, and Steep is cranky about these
            default_value = _ = @default
            return default_value unless default_value.is_a?(Proc)

            default_value.call
          end

          def default?
            @default_present
          end
        end
      end

      class ConstBase < Base
        def initialize # rubocop:disable Lint/MissingSuper
          raise "Cannot instantiate abstract Field" unless self.class < ConstBase

          @errors = []
          @value_set = true
          @value = const
        end
      end

      class PropBase < Base
        def initialize(*value) # rubocop:disable Lint/MissingSuper
          raise "Cannot instantiate abstract Field" unless self.class < PropBase
          raise ArgumentError, "Wrong number of arguments" if value.size > 1

          if value.empty?
            unset_value
            return
          end

          self.value = value.first
        end

        def value=(val)
          if val.nil? && required?
            @value_set = !default?
            @value = default
            return
          end

          @value_set = true
          @value = val
        end

        def unset_value
          @value_set = !default?
          @value = default
        end

        def self.coerce(_value)
          raise NotImplementedError
        end
      end

      class << self # rubocop:disable Metrics/ClassLength
        def array(field_name:, items:, unique: false, required: false, json_name: nil, const: :undefined, # rubocop:disable Metrics/MethodLength
                  default: :undefined)
          validator = Validator::ArrayValidator.new(items: items, unique: unique, required: required)
          Field(
            field_name: field_name,
            type: :array,
            validator: validator,
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            raise TypeError, "Expected Array, got #{value.class}" unless value.is_a?(::Array) || value.nil?
            next value if value.nil?

            value.map do |item|
              next item if validator.raw_types.any? { |type| item.is_a?(type) } || item.nil?

              if item.is_a?(Hash)
                coerced_value = validator.raw_types.filter_map do |type|
                  next nil unless type < SBOM::CycloneDX::Record::Base

                  begin
                    type.new(**item)
                  rescue StandardError
                    nil
                  end
                end

                next coerced_value.first if coerced_value.any?
              end

              raise TypeError, "Expected one of #{items.to_json}, got #{value.class}"
            end
          end
        end

        def boolean(field_name:, json_name: nil, required: false, const: :undefined, default: :undefined) # rubocop:disable Metrics/MethodLength
          Field(
            field_name: field_name,
            type: :boolean,
            validator: SBOM::CycloneDX::Validator::BooleanValidator.new(required: required),
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if value.is_a?(TrueClass) || value.is_a?(FalseClass) || value.nil?

            raise TypeError, "Expected Boolean, got #{value.class}"
          end
        end

        def date_time(field_name:, json_name: nil, required: false, const: :undefined, default: :undefined) # rubocop:disable Metrics/MethodLength
          Field(
            field_name: field_name,
            type: :date_time,
            validator: SBOM::CycloneDX::Validator::DateTimeValidator.new(required: required),
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if value.is_a?(::Time) || value.is_a?(::DateTime) || value.is_a?(::String) || value.nil?

            raise TypeError, "Expected Time, DateTime, or String, got #{value.class}"
          end
        end

        def email_address(field_name:, json_name: nil, required: false, const: :undefined, default: :undefined) # rubocop:disable Metrics/MethodLength
          Field(
            field_name: field_name,
            type: :email_address,
            validator: SBOM::CycloneDX::Validator::EmailAddressValidator.new(required: required),
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if value.is_a?(EmailAddress::Address) || value.is_a?(String) || value.nil?

            raise TypeError, "Expected EmailAddress::Address or String, got #{value.class}"
          end
        end

        def float(field_name:, minimum: nil, maximum: nil, required: false, const: :undefined, default: :undefined, # rubocop:disable Metrics/MethodLength
                  json_name: nil)
          Field(
            field_name: field_name,
            type: :float,
            validator: SBOM::CycloneDX::Validator::FloatValidator.new(
              minimum: minimum,
              maximum: maximum,
              required: required
            ),
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if value.is_a?(::Float) || value.nil?

            raise TypeError, "Expected Float, got #{value.class}"
          end
        end

        def integer(field_name:, minimum: nil, maximum: nil, required: false, const: :undefined, default: :undefined, # rubocop:disable Metrics/MethodLength
                    json_name: nil)
          Field(
            field_name: field_name,
            type: :integer,
            validator: SBOM::CycloneDX::Validator::IntegerValidator.new(
              minimum: minimum,
              maximum: maximum,
              required: required
            ),
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if value.is_a?(::Integer) || value.nil?

            raise TypeError, "Expected Integer, got #{value.class}"
          end
        end

        def record(field_name:, klass:, json_name: nil, required: false, const: :undefined, default: :undefined) # rubocop:disable Metrics/MethodLength
          Field(
            field_name: field_name,
            type: klass,
            validator: SBOM::CycloneDX::Validator::RecordValidator.new(type: klass, required: required),
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if value.is_a?(klass) || value.nil?
            next klass.new(**value) if value.is_a?(::Hash)

            raise TypeError, "Expected #{klass.name}, got #{value.class}"
          end
        end

        def string( # rubocop:disable Metrics/MethodLength
          field_name:,
          enum: nil,
          max_length: nil,
          min_length: nil,
          pattern: Pattern::DEFAULT,
          required: false,
          const: :undefined,
          default: :undefined,
          json_name: nil
        )
          Field(
            field_name: field_name,
            type: :string,
            validator: SBOM::CycloneDX::Validator::StringValidator.new(
              enum: enum,
              max_length: max_length,
              min_length: min_length,
              pattern: pattern,
              required: required
            ),
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if value.is_a?(::String) || value.nil?

            raise TypeError, "Expected String, got #{value.class}"
          end
        end

        def union(field_name:, of:, required: false, const: :undefined, default: :undefined, json_name: nil) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
          validator = SBOM::CycloneDX::Validator::UnionValidator.new(required: required, of: of)
          Field(
            field_name: field_name,
            type: :union,
            validator: validator,
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if validator.raw_types.any? { |type| value.is_a?(type) } || value.nil?

            if value.is_a?(Hash)
              coerced_value = validator.raw_types.filter_map do |type|
                next nil unless type < SBOM::CycloneDX::Record::Base

                begin
                  type.new(**value)
                rescue StandardError
                  nil
                end
              end

              next coerced_value.first if coerced_value.any?
            end

            raise TypeError, "Expected one of #{of.map(&:to_s).join(", ")}, got #{value.class}"
          end
        end

        def uri(field_name:, json_name: nil, required: false, const: :undefined, default: :undefined) # rubocop:disable Metrics/MethodLength
          Field(
            field_name: field_name,
            type: :uri,
            validator: SBOM::CycloneDX::Validator::URIValidator.new(required: required),
            json_name: json_name,
            const: const,
            default: default
          ) do |value|
            next value if value.is_a?(::URI::Generic) || value.is_a?(::String) || value.nil?

            raise TypeError, "Expected URI or String, got #{value.class}"
          end
        end

        private

        def make_const_default_hash(const, default)
          raise ArgumentError, "Can not set both :const and :default" if const != :undefined && default != :undefined

          return { const: const } if const != :undefined
          return { default: default } if default != :undefined

          {}
        end

        def Field(field_name:, type:, validator:, json_name: nil, const: :undefined, default: :undefined, &coerce_block) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Naming/MethodName
          const_and_default_set = const != :undefined && default != :undefined
          raise "Can not set both :const and :default" if const_and_default_set

          const_present = const != :undefined
          const_value = const_present ? const : nil #: fieldValue
          default_present = default != :undefined
          default_value = default_present ? default : nil #: defaultValue[fieldValue]

          json_name ||= field_name.to_s.camelize(:lower)

          const_and_default = {} #: { ?const: fieldValue?, ?default: defaultValue[fieldValue]? }
          const_and_default[:const] = const_value if const_present
          const_and_default[:default] = default_value if default_present

          validate_types(type, validator, **const_and_default)

          base_klass = const_present ? ConstBase : PropBase

          _ = Class.new(base_klass).tap do |field_class|
            field_class.instance_variable_set(:@field_name, field_name)
            field_class.instance_variable_set(:@validator, validator)
            field_class.instance_variable_set(:@json_name, json_name)
            field_class.instance_variable_set(:@const_present, const_present)
            field_class.instance_variable_set(:@const, const_value)
            field_class.instance_variable_set(:@default_present, default_present)
            field_class.instance_variable_set(:@default, default_value)
            field_class.define_singleton_method(:coerce, &coerce_block)
          end
        end

        def validate_types(type, validator, **const_and_default) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/AbcSize,Metrics/PerceivedComplexity
          const_set = const_and_default.key?(:const)
          const = const_and_default[:const]
          default_set = const_and_default.key?(:default)
          default = const_and_default[:default].then { |dv| dv.is_a?(Proc) ? dv.call : dv }

          validator_klass =
            case type
            when :array then Validator::ArrayValidator
            when :boolean then Validator::BooleanValidator
            when :date_time then Validator::DateTimeValidator
            when :email_address then Validator::EmailAddressValidator
            when :float then Validator::FloatValidator
            when :integer then Validator::IntegerValidator
            when Class then Validator::RecordValidator
            when :string then Validator::StringValidator
            when :union then Validator::UnionValidator
            when :uri then Validator::URIValidator
            else raise "Unknown type: #{type}"
            end

          unless validator.is_a?(validator_klass)
            raise TypeError, "Incorrect validator #{validator.class.name} for #{type}"
          end

          const_errors = const_set ? validator.validate(const) : [] #: ::Array[String]
          default_errors = default_set ? validator.validate(default) : [] #: ::Array[String]

          raise "Invalid value for const:\n#{const_errors.join("\n")}" if const_errors.any?
          raise "Invalid value for default:\n#{default_errors.join("\n")}" if default_errors.any?
        end
      end
    end
  end
end
