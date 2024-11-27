# frozen_string_literal: true

require_relative "base"
require_relative "../validator/uri_validator"

module SBOM
  module CycloneDX
    module Field
      class URI < Base
        def initialize(name:, required: false, const: NOT_SET, default: NOT_SET, json_name: nil)
          super(
            type: :uri,
            name: name,
            validator: SBOM::CycloneDX::Validator::URIValidator.new(required: required),
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
