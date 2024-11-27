# frozen_string_literal: true

require_relative "base"
require_relative "../validator/union_validator"

module SBOM
  module CycloneDX
    module Field
      class Union < Base
        def initialize(name:, of:, required: false, const: NOT_SET, default: NOT_SET, json_name: nil)
          super(
            type: :union,
            name: name,
            validator: SBOM::CycloneDX::Validator::UnionValidator.new(required: required, of: of),
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
