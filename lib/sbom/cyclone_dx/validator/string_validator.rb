# frozen_string_literal: true

require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class StringValidator < BaseValidator
        # TODO: Validate max/min_length >= 0 and max_length >= min_length
        def initialize(enum: nil, max_length: nil, min_length: nil, pattern: //, required: true, **kwargs)
          super(required: required, **kwargs)

          @enum = enum
          @length_range = (min_length..max_length)
          @pattern = pattern
        end

        def valid?(value)
          return false unless super(value, String)
          return false if @enum&.exclude?(value)

          @length_range.cover?(value.length) && @pattern.match?(value)
        end
      end
    end
  end
end
