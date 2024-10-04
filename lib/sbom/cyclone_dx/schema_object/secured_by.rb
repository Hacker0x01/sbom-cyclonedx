# frozen_string_literal: true
# rbs_inline: enabled

# Secured By - Specifies the mechanism by which the cryptographic asset is secured by
module SBOM
  module CycloneDX
    SecuredBy = SchemaObject.build("SecuredBy") do
      # Mechanism - Specifies the mechanism by which the cryptographic asset is secured by.
      # Examples: "HSM", "TPM", "SGX", "Software", "None"
      prop :mechanism, String

      # Algorithm Reference - The bom-ref to the algorithm.
      prop :algorithm_ref, String, pattern: Pattern::REF_LINK
    end
  end
end
