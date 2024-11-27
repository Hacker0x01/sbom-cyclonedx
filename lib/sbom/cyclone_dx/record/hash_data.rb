# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"

# Hash
module SBOM
  module CycloneDX
    module Record
      # Schema name: HashData
      class HashData < Base
        prop :alg, :string, enum: Enum::HASH_ALG, required: true
        prop :content, :string, pattern: Pattern::HASH_VALUE, required: true
      end
    end
  end
end
