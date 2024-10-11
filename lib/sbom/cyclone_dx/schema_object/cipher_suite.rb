# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"

# Cipher Suite - Object representing a cipher suite
module SBOM
  module CycloneDX
    class CipherSuite < Struct.new(
      "CipherSuite",
      # Common Name - A common name for the cipher suite.
      # Example: "TLS_DHE_RSA_WITH_AES_128_CCM"
      :name,
      # Related Algorithms - A list of algorithms related to the cipher suite.
      :algorithms,
      # Cipher Suite Identifiers - A list of common identifiers for the cipher suite.
      # Examples: "0xC0", "0x9E"
      :identifiers,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, name) &&
          Validator.valid?(Array, algorithms, items: [String, pattern: Pattern::REF_LINK]) &&
          Validator.valid?(Array, identifiers, items: String)
      end
    end
  end
end
