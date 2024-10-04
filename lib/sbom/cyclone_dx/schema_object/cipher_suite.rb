# frozen_string_literal: true
# rbs_inline: enabled

# Cipher Suite - Object representing a cipher suite
module SBOM
  module CycloneDX
    CipherSuite = SchemaObject.build("CipherSuite") do
      # Common Name - A common name for the cipher suite.
      # Example: "TLS_DHE_RSA_WITH_AES_128_CCM"
      prop :name, String

      # Related Algorithms - A list of algorithms related to the cipher suite.
      prop :algorithms, [String], all: { pattern: Pattern::REF_LINK }

      # Cipher Suite Identifiers - A list of common identifiers for the cipher suite.
      # Examples: "0xC0", "0x9E"
      prop :identifiers, [String]
    end
  end
end
