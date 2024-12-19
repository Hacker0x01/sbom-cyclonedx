# frozen_string_literal: true

require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class BooleanValidator < BaseValidator
        def initialize(required: false)
          super(TrueClass, FalseClass, required: required)
        end
      end
    end
  end
end
