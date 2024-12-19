# frozen_string_literal: true

require_relative "base_validator"
require_relative "../validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class UnionValidator < BaseValidator
        def initialize(of:, required: false)
          super(required: required)

          @nested_validators = []

          of.each do |union_item|
            (klass, validator_params) = union_item.is_a?(Array) ? union_item : [union_item, {}]

            @nested_validators << Validator.for(klass, required: required, **validator_params)
          end
        end

        def validate(value)
          # TODO: Build message based on type and params, e.g.
          # "Expected one of: [String, Integer], got: Float"
          # "Expected one of: [String with length <= 2, Integer with maximum 99], got: String with length 3"
          rv = @nested_validators.map { |validator| validator.validate(value) }
          return [] if rv.any?(&:empty?)

          rv.flatten
        end

        def raw_types
          @nested_validators.flat_map(&:raw_types)
        end
      end
    end
  end
end
