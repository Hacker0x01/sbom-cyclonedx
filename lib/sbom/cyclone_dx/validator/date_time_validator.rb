# frozen_string_literal: true

require "date"
require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class DateTimeValidator < BaseValidator
        def initialize(required: false)
          super(DateTime, Time, String, required: required)
        end

        def validate(value)
          rv = super
          return rv unless value.is_a?(String)

          begin
            DateTime.iso8601(value)
            rv
          rescue ArgumentError, TypeError
            rv << "Invalid ISO8601 date-time"
          end
        end
      end
    end
  end
end
