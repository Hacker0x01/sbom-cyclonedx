# frozen_string_literal: true

require_relative "base"
require_relative "../validator/boolean_validator"

module SBOM
  module CycloneDX
    module Field
      class Boolean < Base
        def initialize(name:, required: false, const: NOT_SET, default: NOT_SET, json_name: nil)
          super(
            type: :boolean,
            name: name,
            validator: SBOM::CycloneDX::Validator::BooleanValidator.new(required: required),
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
