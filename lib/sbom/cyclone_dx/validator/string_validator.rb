# frozen_string_literal: true

require_relative "base_validator"
require_relative "../pattern"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class StringValidator < BaseValidator
        # TODO: Validate max/min_length >= 0 and max_length >= min_length
        def initialize(enum: nil, max_length: nil, min_length: nil, pattern: Pattern::DEFAULT, required: true)
          super(String, required: required)

          @enum = enum
          @length_range = (min_length..max_length)
          @pattern = pattern
        end

        def validate(value)
          rv = super
          return rv unless value.is_a?(String)

          rv << "Value is not within enum" if @enum&.exclude?(value)
          rv << "Value is not within length range" unless @length_range.cover?(value.length)
          rv << "Value does not match pattern" unless Pattern.match_exactly?(@pattern, value)

          rv
        end
      end
    end
  end
end
