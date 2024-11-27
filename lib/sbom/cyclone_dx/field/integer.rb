# frozen_string_literal: true

require_relative "base"
require_relative "../validator/integer_validator"

module SBOM
  module CycloneDX
    module Field
      class Integer < Base
        def initialize(
          name:,
          minimum: nil,
          maximum: nil,
          required: false,
          const: NOT_SET,
          default: NOT_SET,
          json_name: nil
        )
          super(
            type: :integer,
            name: name,
            validator: SBOM::CycloneDX::Validator::IntegerValidator.new(
              minimum: minimum,
              maximum: maximum,
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
