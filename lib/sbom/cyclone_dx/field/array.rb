# frozen_string_literal: true

require_relative "base"
require_relative "../validator/array_validator"

module SBOM
  module CycloneDX
    module Field
      class Array < Base
        def initialize(name:, items:, unique: false, required: false, const: NOT_SET, default: NOT_SET, json_name: nil)
          super(
            type: :array,
            name: name,
            validator: SBOM::CycloneDX::Validator::ArrayValidator.new(items: items, unique: unique, required: required),
            required: required,
            json_name: json_name,
            const: const,
            default: default
          )
        end
      end
    end
  end
end
