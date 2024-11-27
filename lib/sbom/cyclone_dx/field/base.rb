# frozen_string_literal: true

require_relative "../validator/array_validator"
require_relative "../validator/boolean_validator"
require_relative "../validator/date_time_validator"
require_relative "../validator/email_address_validator"
require_relative "../validator/float_validator"
require_relative "../validator/integer_validator"
require_relative "../validator/record_validator"
require_relative "../validator/string_validator"
require_relative "../validator/union_validator"
require_relative "../validator/uri_validator"

module SBOM
  module CycloneDX
    module Field
      class Base
        attr_reader :name, :required, :type, :const, :default, :validator, :json_name

        def initialize(type:, name:, validator:, required: false, json_name: nil, const: NOT_SET, default: NOT_SET)
          raise "Cannot instantiate abstract Field" unless self.class < Base

          @use_const = false
          @use_default = false

          @name = name
          @json_name = json_name || name.to_s.camelize(:lower)
          @required = required

          const = resolve_optional(:const, const)
          default = resolve_optional(:default, default)

          validate_types(type, validator, const, default)

          @type = type
          @validator = validator
          @const = const
          @default = default
        end

        def const?
          @use_const
        end

        def default?
          @use_default
        end

        private

        def resolve_optional(name, value)
          raise "Only applicable to :const and :default" unless %i[const default].include?(name)

          if value == NOT_SET
            instance_variable_set(:"@use_#{name}", false)
            return nil
          end

          instance_variable_set(:"@use_#{name}", true)
          _ = value # Forget type so we can assert it in the RBS file
        end

        def validate_types(type, validator, const, default) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/AbcSize,Metrics/PerceivedComplexity
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

          raise "Invalid value for const:\n#{validator.errors.join("\n")}" if const? && !validator.valid?(const)
          raise "Invalid value for default:\n#{validator.errors.join("\n")}" if default? && !validator.valid?(default)
        end
      end
    end
  end
end
