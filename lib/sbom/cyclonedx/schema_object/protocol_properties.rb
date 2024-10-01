# frozen_string_literal: true
# rbs_inline: enabled

# Protocol Properties - Properties specific to cryptographic assets of type: `protocol`.
module SBOM
  module Cyclonedx
    class ProtocolProperties < SchemaObject
      # Type - The concrete protocol type.
      attr_accessor :type #: ProtocolType

      # Protocol Version - The version of the protocol.
      # Examples: "1.0", "1.2", "1.99"
      attr_accessor :version #: String

      # Cipher Suites - A list of cipher suites related to the protocol.
      attr_accessor :cipher_suites #: [CipherSuite]

      # IKEv2 Transform Types - The IKEv2 transform types supported (types 1-4), defined in [RFC 7296 section 3.3.2](https://www.ietf.org/rfc/rfc7296.html#section-3.3.2), and additional properties.
      attr_accessor :ikev2_transform_types #: Ikev2TransformType

      # Cryptographic References - A list of protocol-related cryptographic assets
      attr_accessor :crypto_ref_array #: CryptoRefArray
    end
  end
end
