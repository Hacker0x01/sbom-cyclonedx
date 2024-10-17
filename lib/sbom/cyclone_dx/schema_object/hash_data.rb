# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Hash
module SBOM
  module CycloneDX
    class HashData < Struct.new(
      "HashData",
      :alg,
      :content,
      keyword_init: true
    )
      include SchemaObject

      def initialize(alg:, content:) # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def valid?
        Validator.valid?(String, alg, enum: Enum::HASH_ALG, required: true) &&
          Validator.valid?(String, content, pattern: Pattern::HASH_VALUE, required: true)
      end
    end
  end
end
