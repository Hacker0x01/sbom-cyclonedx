# frozen_string_literal: true

require_relative "base_validator"
require_relative "../validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class UnionValidator < BaseValidator
        def initialize(of:, required: false, **kwargs)
          super(required: required, **kwargs)

          @nested_validators = []

          of.each do |union_item|
            (klass, validator_params) = union_item.is_a?(Array) ? union_item : [union_item, {}]

            @nested_validators << Validator.for(klass, required: required, **validator_params)
          end
        end

        def valid?(value)
          @nested_validators.any? { |validator| validator.valid?(value) }
        end
      end
    end
  end
end
