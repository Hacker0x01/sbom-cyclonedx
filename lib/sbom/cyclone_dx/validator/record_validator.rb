# frozen_string_literal: true

require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class RecordValidator < BaseValidator
        def initialize(type:, required: false, **kwargs)
          super(required: required, **kwargs)

          @record_type = type
        end

        def valid?(value)
          super(value, @record_type)
        end
      end
    end
  end
end
