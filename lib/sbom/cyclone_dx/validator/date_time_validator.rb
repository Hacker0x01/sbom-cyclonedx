# frozen_string_literal: true

require "date"
require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class DateTimeValidator < BaseValidator
        def valid?(value)
          return false unless super(value, DateTime, Time, String)
          return true unless value.is_a?(String)

          begin
            DateTime.iso8601(value)
            true
          rescue ArgumentError, TypeError
            false
          end
        end
      end
    end
  end
end
