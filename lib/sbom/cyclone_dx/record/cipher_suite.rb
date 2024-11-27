# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"

# Cipher Suite - Object representing a cipher suite
module SBOM
  module CycloneDX
    module Record
      # Schema name: CipherSuite
      class CipherSuite < Base
        # Common Name - A common name for the cipher suite.
        # Example: "TLS_DHE_RSA_WITH_AES_128_CCM"
        prop :name, :string
        # Related Algorithms - A list of algorithms related to the cipher suite.
        prop :algorithms, :array, items: [:string, pattern: Pattern::REF_LINK]
        # Cipher Suite Identifiers - A list of common identifiers for the cipher suite.
        # Examples: "0xC0", "0x9E"
        prop :identifiers, :array, items: :string
      end
    end
  end
end
