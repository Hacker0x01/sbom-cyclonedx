# frozen_string_literal: true
# rbs_inline: enabled

# Algorithm Properties - Additional properties specific to a cryptographic algorithm.
module Sbom
  module Cyclonedx
    class AlgorithmProperties < SchemaObject
      # primitive - Cryptographic building blocks used in higher-level cryptographic systems and protocols. Primitives represent different cryptographic routines: deterministic random bit generators (drbg, e.g. CTR_DRBG from NIST SP800-90A-r1), message authentication codes (mac, e.g. HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20), signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key encryption schemes (pke, e.g. RSA), extended output functions (xof, e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM), authenticated encryption (ae, e.g. AES-GCM) and the combination of multiple algorithms (combiner, e.g. SP800-56Cr2).
      attr_accessor :primitive #: Primitive

      # Parameter Set Identifier - An identifier for the parameter set of the cryptographic algorithm. Examples: in AES128, '128' identifies the key length in bits, in SHA256, '256' identifies the digest length, '128' in SHAKE128 identifies its maximum security level in bits, and 'SHA2-128s' identifies a parameter set used in SLH-DSA (FIPS205).
      attr_accessor :parameter_set_identifier #: String

      # Elliptic Curve - The specific underlying Elliptic Curve (EC) definition employed which is an indicator of the level of security strength, performance and complexity. Absent an authoritative source of curve names, CycloneDX recommends using curve names as defined at [https://neuromancer.sk/std/](https://neuromancer.sk/std/), the source of which can be found at [https://github.com/J08nY/std-curves](https://github.com/J08nY/std-curves).
      attr_accessor :curve #: String

      # Execution Environment - The target and execution environment in which the algorithm is implemented in.
      attr_accessor :execution_environment #: ExecutionEnvironment

      # Implementation platform - The target platform for which the algorithm is implemented. The implementation can be 'generic', running on any platform or for a specific platform.
      attr_accessor :implementation_platform #: ImplementationPlatform

      # Certification Level - The certification that the implementation of the cryptographic algorithm has received, if any. Certifications include revisions and levels of FIPS 140 or Common Criteria of different Extended Assurance Levels (CC-EAL).
      attr_accessor :certification_level #: [CertificationLevel]

      # Mode - The mode of operation in which the cryptographic algorithm (block cipher) is used.
      attr_accessor :mode #: AlgorithmMode

      # Padding - The padding scheme that is used for the cryptographic algorithm.
      attr_accessor :padding #: Padding

      # Cryptographic functions - The cryptographic functions implemented by the cryptographic algorithm.
      attr_accessor :crypto_functions #: [CryptoFunctions]

      # classical security level - The classical security level that a cryptographic algorithm provides (in bits).
      attr_accessor :classical_security_level #: Integer

      # NIST security strength category - The NIST security strength category as defined in https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria). A value of 0 indicates that none of the categories are met.
      attr_accessor :nist_quantum_security_level #: Integer

      validate :classical_security_level, minimum: 0
      validate :nist_quantum_security_level, minimum: 0, maximum: 6
    end
  end
end
