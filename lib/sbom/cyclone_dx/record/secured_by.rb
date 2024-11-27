# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"

# Secured By - Specifies the mechanism by which the cryptographic asset is secured by
module SBOM
  module CycloneDX
    module Record
      # Schema name: SecuredBy
      class SecuredBy < Base
        # Mechanism - Specifies the mechanism by which the cryptographic asset is secured by.
        # Examples: "HSM", "TPM", "SGX", "Software", "None"
        prop :mechanism, :string
        # Algorithm Reference - The bom-ref to the algorithm.
        prop :algorithm_ref, :string, pattern: Pattern::REF_LINK
      end
    end
  end
end
