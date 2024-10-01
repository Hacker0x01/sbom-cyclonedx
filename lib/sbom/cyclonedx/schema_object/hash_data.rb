# frozen_string_literal: true
# rbs_inline: enabled

# Hash
module SBOM
  module Cyclonedx
    class HashData < SchemaObject
      attr_accessor :alg #: HashAlg

      validate :alg, required: true

      attr_accessor :content #: HashValue

      validate :content, required: true
    end
  end
end
