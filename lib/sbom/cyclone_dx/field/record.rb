# frozen_string_literal: true

require_relative "base"
require_relative "../validator/record_validator"

module SBOM
  module CycloneDX
    module Field
      class Record < Base
        def initialize(type:, name:, required: false, const: NOT_SET, default: NOT_SET, json_name: nil)
          super(
            type: type,
            name: name,
            validator: SBOM::CycloneDX::Validator::RecordValidator.new(type: type, required: required),
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
