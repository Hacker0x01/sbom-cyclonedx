# frozen_string_literal: true

require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class IntegerValidator < BaseValidator
        def initialize(maximum: nil, minimum: nil, required: false)
          if maximum && minimum && maximum < minimum
            raise ArgumentError, "maximum must be greater than or equal to minimum"
          end

          super(Integer, required: required)

          @range = (minimum..maximum)
        end

        def validate(value)
          rv = super
          return rv unless value.is_a?(Integer)

          rv << "Value is not within range" unless @range.cover?(value)
          rv
        end
      end
    end
  end
end
