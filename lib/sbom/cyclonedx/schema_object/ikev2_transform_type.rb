# frozen_string_literal: true
# rbs_inline: enabled

# IKEv2 Transform Types - The IKEv2 transform types supported (types 1-4), defined in [RFC 7296 section 3.3.2](https://www.ietf.org/rfc/rfc7296.html#section-3.3.2), and additional properties.
module Sbom
  module Cyclonedx
    class Ikev2TransformType < SchemaObject
      # Encryption Algorithm (ENCR) - Transform Type 1: encryption algorithms
      attr_accessor :encr #: CryptoRefArray

      # Pseudorandom Function (PRF) - Transform Type 2: pseudorandom functions
      attr_accessor :prf #: CryptoRefArray

      # Integrity Algorithm (INTEG) - Transform Type 3: integrity algorithms
      attr_accessor :integ #: CryptoRefArray

      # Key Exchange Method (KE) - Transform Type 4: Key Exchange Method (KE) per [RFC 9370](https://www.ietf.org/rfc/rfc9370.html), formerly called Diffie-Hellman Group (D-H).
      attr_accessor :ke #: CryptoRefArray

      # Extended Sequence Numbers (ESN) - Specifies if an Extended Sequence Number (ESN) is used.
      attr_accessor :esn #: bool

      # IKEv2 Authentication method - IKEv2 Authentication method
      attr_accessor :auth #: CryptoRefArray
    end
  end
end
