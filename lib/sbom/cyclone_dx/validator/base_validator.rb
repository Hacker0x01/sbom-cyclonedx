# frozen_string_literal: true

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class BaseValidator
        MISSING_REQUIRED = "Required property is missing or nil"
        INVALID_TYPE = "Invalid type `%s`, expected: %s"

        def initialize(*types, required: false)
          raise "Abstract class BaseValidator cannot be instantiated" unless self.class < BaseValidator

          @types = types
          @required = required
        end

        def valid?(value)
          validate(value).empty?
        end

        def validate(value) # rubocop:disable Metrics/CyclomaticComplexity
          errors = [] #: Array[String]

          errors << MISSING_REQUIRED if required? && value.nil?
          return errors if errors.any?
          return errors if @types.any? { |type| value.is_a?(type) }
          return errors if value.nil? && !required?

          errors << format(INVALID_TYPE, value.class.name, @types.join(", "))
        end

        def required?
          @required
        end

        def raw_types
          @types
        end
      end
    end
  end
end
