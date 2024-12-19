# frozen_string_literal: true

require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class RecordValidator < BaseValidator
        def initialize(type:, required: false)
          super(type, required: required)

          @record_type = type
        end

        def validate(value)
          rv = super
          return rv unless value.is_a?(@record_type)

          rv += value.valid? ? [] : value.formatted_errors
          rv.compact
        end
      end
    end
  end
end
