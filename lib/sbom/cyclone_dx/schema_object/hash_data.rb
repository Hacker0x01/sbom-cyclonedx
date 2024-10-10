# frozen_string_literal: true
# rbs_inline: enabled

# Hash
module SBOM
  module CycloneDX
    HashData = SchemaObject.build("HashData") do
      json_alias "hash"

      prop :alg, String, enum: Enum::HASH_ALG, required: true
      prop :content, String, required: true, pattern: Pattern::HASH_VALUE
    end
  end
end
