# frozen_string_literal: true

require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class IntegerValidator < BaseValidator
        def initialize(maximum: nil, minimum: nil, required: false, **kwargs)
          super(required: required, **kwargs)

          @range = (minimum..maximum)
        end

        def valid?(value)
          return false unless super(value, Float)

          @range.cover?(value)
        end
      end
    end
  end
end
