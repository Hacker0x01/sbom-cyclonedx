# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Secured By - Specifies the mechanism by which the cryptographic asset is secured by
module SBOM
  module CycloneDX
    class SecuredBy < Struct.new(
      "SecuredBy",
      # Mechanism - Specifies the mechanism by which the cryptographic asset is secured by.
      # Examples: "HSM", "TPM", "SGX", "Software", "None"
      # prop :mechanism, String
      :mechanism,
      # Algorithm Reference - The bom-ref to the algorithm.
      # prop :algorithm_ref, String, pattern: Pattern::REF_LINK
      :algorithm_ref,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, mechanism) &&
          Validator.valid?(String, algorithm_ref, pattern: Pattern::REF_LINK)
      end
    end
  end
end
