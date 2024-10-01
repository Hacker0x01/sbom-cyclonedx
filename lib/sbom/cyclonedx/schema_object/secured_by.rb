# frozen_string_literal: true
# rbs_inline: enabled

# Secured By - Specifies the mechanism by which the cryptographic asset is secured by
module SBOM
  module Cyclonedx
    class SecuredBy < SchemaObject
      # Mechanism - Specifies the mechanism by which the cryptographic asset is secured by.
      # Examples: "HSM", "TPM", "SGX", "Software", "None"
      attr_accessor :mechanism #: String

      # Algorithm Reference - The bom-ref to the algorithm.
      attr_accessor :algorithm_ref #: RefLink
    end
  end
end
