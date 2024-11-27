# frozen_string_literal: true

require_relative "base"
require_relative "../validator/string_validator"

module SBOM
  module CycloneDX
    module Field
      class String < Base
        def initialize(
          name:,
          enum: nil,
          max_length: nil,
          min_length: nil,
          pattern: //,
          required: false,
          const: NOT_SET,
          default: NOT_SET,
          json_name: nil
        )
          super(
            type: :string,
            name: name,
            validator: SBOM::CycloneDX::Validator::StringValidator.new(
              enum: enum,
              max_length: max_length,
              min_length: min_length,
              pattern: pattern,
              required: required
            ),
            required: required,
            const: const,
            default: default,
            json_name: json_name
          )
        end
      end
    end
  end
end
