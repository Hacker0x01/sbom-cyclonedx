# frozen_string_literal: true
# rbs_inline: enabled

# Cipher Suite - Object representing a cipher suite
module SBOM
  module Cyclonedx
    class CipherSuite < SchemaObject
      # Common Name - A common name for the cipher suite.
      # Example: "TLS_DHE_RSA_WITH_AES_128_CCM"
      attr_accessor :name #: String

      # Related Algorithms - A list of algorithms related to the cipher suite.
      attr_accessor :algorithms #: [RefLink]

      # Cipher Suite Identifiers - A list of common identifiers for the cipher suite.
      # Examples: "0xC0", "0x9E"
      attr_accessor :identifiers #: [String]
    end
  end
end
