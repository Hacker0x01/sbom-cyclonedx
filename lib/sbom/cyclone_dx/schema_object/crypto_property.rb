# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Cryptographic Properties - Cryptographic assets have properties that uniquely define them and that make them actionable for further reasoning. As an example, it makes a difference if one knows the algorithm family (e.g. AES) or the specific variant or instantiation (e.g. AES-128-GCM). This is because the security level and the algorithm primitive (authenticated encryption) are only defined by the definition of the algorithm variant. The presence of a weak cryptographic algorithm like SHA1 vs. HMAC-SHA1 also makes a difference.
module SBOM
  module CycloneDX
    class CryptoProperty < Struct.new(
      "CryptoProperty",
      # Asset Type - Cryptographic assets occur in several forms. Algorithms and protocols are most commonly implemented in specialized cryptographic libraries. They may, however, also be 'hardcoded' in software components. Certificates and related cryptographic material like keys, tokens, secrets or passwords are other cryptographic assets to be modelled.
      :asset_type,
      # Algorithm Properties - Additional properties specific to a cryptographic algorithm.
      :algorithm_properties,
      # Certificate Properties - Properties for cryptographic assets of asset type 'certificate'
      :certificate_properties,
      # Related Cryptographic Material Properties - Properties for cryptographic assets of asset type: `related-crypto-material`
      :related_crypto_material_properties,
      # Protocol Properties - Properties specific to cryptographic assets of type: `protocol`.
      :protocol_properties,
      # OID - The object identifier (OID) of the cryptographic asset.
      :oid,
      keyword_init: true
    )
      include SchemaObject

      def initialize( # rubocop:disable Metrics/ParameterLists
        asset_type:,
        algorithm_properties: nil,
        certificate_properties: nil,
        related_crypto_material_properties: nil,
        protocol_properties: nil,
        oid: nil
      )
        super
      end

      def valid?
        Validator.valid?(String, asset_type, enum: Enum::ASSET_TYPE, required: true) &&
          Validator.valid?(AlgorithmProperties, algorithm_properties) &&
          Validator.valid?(CertificateProperties, certificate_properties) &&
          Validator.valid?(RelatedCryptoMaterialProperties, related_crypto_material_properties) &&
          Validator.valid?(ProtocolProperties, protocol_properties) &&
          Validator.valid?(String, oid)
      end

      class AlgorithmProperties < Struct.new(
        "AlgorithmProperties",
        # primitive - Cryptographic building blocks used in higher-level cryptographic systems and protocols. Primitives represent different cryptographic routines: deterministic random bit generators (drbg, e.g. CTR_DRBG from NIST SP800-90A-r1), message authentication codes (mac, e.g. HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20), signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key encryption schemes (pke, e.g. RSA), extended output functions (xof, e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM), authenticated encryption (ae, e.g. AES-GCM) and the combination of multiple algorithms (combiner, e.g. SP800-56Cr2).
        :primitive,
        # Parameter Set Identifier - An identifier for the parameter set of the cryptographic algorithm. Examples: in AES128, '128' identifies the key length in bits, in SHA256, '256' identifies the digest length, '128' in SHAKE128 identifies its maximum security level in bits, and 'SHA2-128s' identifies a parameter set used in SLH-DSA (FIPS205).
        :parameter_set_identifier,
        # Elliptic Curve - The specific underlying Elliptic Curve (EC) definition employed which is an indicator of the level of security strength, performance and complexity. Absent an authoritative source of curve names, CycloneDX recommends using curve names as defined at [https://neuromancer.sk/std/](https://neuromancer.sk/std/), the source of which can be found at [https://github.com/J08nY/std-curves](https://github.com/J08nY/std-curves).
        :curve,
        # Execution Environment - The target and execution environment in which the algorithm is implemented in.
        :execution_environment,
        # Implementation platform - The target platform for which the algorithm is implemented. The implementation can be 'generic', running on any platform or for a specific platform.
        :implementation_platform,
        # Certification Level - The certification that the implementation of the cryptographic algorithm has received, if any. Certifications include revisions and levels of FIPS 140 or Common Criteria of different Extended Assurance Levels (CC-EAL).
        :certification_level,
        # Mode - The mode of operation in which the cryptographic algorithm (block cipher) is used.
        :mode,
        # Padding - The padding scheme that is used for the cryptographic algorithm.
        :padding,
        # Cryptographic functions - The cryptographic functions implemented by the cryptographic algorithm.
        :crypto_functions,
        # classical security level - The classical security level that a cryptographic algorithm provides (in bits).
        :classical_security_level,
        # NIST security strength category - The NIST security strength category as defined in https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria). A value of 0 indicates that none of the categories are met.
        :nist_quantum_security_level,
        keyword_init: true
      )
        include SchemaObject

        def valid? # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
          Validator.valid?(String, primitive, enum: Enum::PRIMITIVE) &&
            Validator.valid?(String, parameter_set_identifier) &&
            Validator.valid?(String, curve) &&
            Validator.valid?(String, execution_environment, enum: Enum::EXECUTION_ENVIRONMENT) &&
            Validator.valid?(String, implementation_platform, enum: Enum::IMPLEMENTATION_PLATFORM) &&
            Validator.valid?(
              Array,
              certification_level,
              items: [String, enum: Enum::CERTIFICATION_LEVEL]
            ) &&
            Validator.valid?(String, mode, enum: Enum::ALGORITHM_MODE) &&
            Validator.valid?(String, padding, enum: Enum::PADDING) &&
            Validator.valid?(
              Array,
              crypto_functions,
              items: [String, enum: Enum::CRYPTO_FUNCTION]
            ) &&
            Validator.valid?(Integer, classical_security_level, minimum: 0) &&
            Validator.valid?(Integer, nist_quantum_security_level, minimum: 0, maximum: 6)
        end
      end

      class CertificateProperties < Struct.new(
        "CertificateProperties",
        # Subject Name - The subject name for the certificate
        :subject_name,
        # Issuer Name - The issuer name for the certificate
        :issuer_name,
        # Not Valid Before - The date and time according to ISO-8601 standard from which the certificate is valid
        :not_valid_before,
        # Not Valid After - The date and time according to ISO-8601 standard from which the certificate is not valid anymore
        :not_valid_after,
        # Algorithm Reference - The bom-ref to signature algorithm used by the certificate
        :signature_algorithm_ref,
        # Key reference - The bom-ref to the public key of the subject
        :subject_public_key_ref,
        # Certificate Format - The format of the certificate
        # Examples: "X.509", "PEM", "DER", "CVC"
        :certificate_format,
        # Certificate File Extension - The file extension of the certificate
        # Examples: "crt", "pem", "cer", "der", "p12"
        :certificate_extension,
        keyword_init: true
      )
        include SchemaObject

        def valid? # rubocop:disable Metrics/CyclomaticComplexity
          Validator.valid?(String, subject_name) &&
            Validator.valid?(String, issuer_name) &&
            Validator.valid?(DateTime, not_valid_before) &&
            Validator.valid?(DateTime, not_valid_after) &&
            Validator.valid?(String, signature_algorithm_ref, pattern: Pattern::REF_LINK) &&
            Validator.valid?(String, subject_public_key_ref, pattern: Pattern::REF_LINK) &&
            Validator.valid?(String, certificate_format) &&
            Validator.valid?(String, certificate_extension)
        end
      end

      class ProtocolProperties < Struct.new(
        "ProtocolProperties",
        # Type - The concrete protocol type.
        :type,
        # Protocol Version - The version of the protocol.
        # Examples: "1.0", "1.2", "1.99"
        :version,
        # Cipher Suites - A list of cipher suites related to the protocol.
        :cipher_suites,
        # IKEv2 Transform Types - The IKEv2 transform types supported (types 1-4), defined in [RFC 7296 section 3.3.2](https://www.ietf.org/rfc/rfc7296.html#section-3.3.2), and additional properties.
        :ikev2_transform_types,
        # Cryptographic References - A list of protocol-related cryptographic assets
        :crypto_ref_array,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(String, type, enum: Enum::PROTOCOL_TYPE) &&
            Validator.valid?(String, version) &&
            Validator.valid?(
              Array,
              cipher_suites,
              items: CipherSuite
            ) &&
            Validator.valid?(IKEv2TransformType, ikev2_transform_types) &&
            Validator.valid?(
              Array,
              crypto_ref_array,
              items: [String, pattern: Pattern::REF_LINK]
            )
        end
      end

      class IKEv2TransformType < Struct.new(
        "IKEv2TransformType",
        # Encryption Algorithm (ENCR) - Transform Type 1: encryption algorithms
        :encr,
        # Pseudorandom Function (PRF) - Transform Type 2: pseudorandom functions
        :prf,
        # Integrity Algorithm (INTEG) - Transform Type 3: integrity algorithms
        :integ,
        # Key Exchange Method (KE) - Transform Type 4: Key Exchange Method (KE) per [RFC 9370](https://www.ietf.org/rfc/rfc9370.html), formerly called Diffie-Hellman Group (D-H).
        :ke,
        # Extended Sequence Numbers (ESN) - Specifies if an Extended Sequence Number (ESN) is used.
        :esn,
        # IKEv2 Authentication method - IKEv2 Authentication method
        :auth,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(
            Array,
            encr,
            items: [String, pattern: Pattern::REF_LINK]
          ) &&
            Validator.valid?(
              Array,
              prf,
              items: [String, pattern: Pattern::REF_LINK]
            ) &&
            Validator.valid?(
              Array,
              integ,
              items: [String, pattern: Pattern::REF_LINK]
            ) &&
            Validator.valid?(
              Array,
              ke,
              items: [String, pattern: Pattern::REF_LINK]
            ) &&
            Validator.valid?(Boolean, esn) &&
            Validator.valid?(
              Array,
              auth,
              items: [String, pattern: Pattern::REF_LINK]
            )
        end
      end
    end

    class RelatedCryptoMaterialProperties < Struct.new(
      "RelatedCryptoMaterialProperties",
      # relatedCryptoMaterialType - The type for the related cryptographic material
      :type,
      # ID - The optional unique identifier for the related cryptographic material.
      :id,
      # State - The key state as defined by NIST SP 800-57.
      :state,
      # Algorithm Reference - The bom-ref to the algorithm used to generate the related cryptographic material.
      :algorithm_ref,
      # Creation Date - The date and time (timestamp) when the related cryptographic material was created.
      :creation_date,
      # Activation Date - The date and time (timestamp) when the related cryptographic material was activated.
      :activation_date,
      # Update Date - The date and time (timestamp) when the related cryptographic material was updated.
      :update_date,
      # Expiration Date - The date and time (timestamp) when the related cryptographic material expires.
      :expiration_date,
      # Value - The associated value of the cryptographic material.
      :value,
      # Size - The size of the cryptographic asset (in bits).
      :asset_size,
      # Format - The format of the related cryptographic material (e.g. P8, PEM, DER).
      :format,
      # Secured By - The mechanism by which the cryptographic asset is secured by.
      :secured_by,
      keyword_init: true
    )
      include SchemaObject

      json_name :asset_size, "size"

      def valid?
        Validator.valid?(String, type, enum: Enum::RELATED_CRYPTO_MATERIAL_TYPE) &&
          Validator.valid?(String, id) &&
          Validator.valid?(String, state, enum: Enum::RELATED_CRYPTO_MATERIAL_STATE) &&
          Validator.valid?(String, algorithm_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(DateTime, creation_date) &&
          Validator.valid?(DateTime, activation_date) &&
          Validator.valid?(DateTime, update_date) &&
          Validator.valid?(DateTime, expiration_date) &&
          Validator.valid?(String, value) &&
          Validator.valid?(Integer, asset_size) &&
          Validator.valid?(String, format) &&
          Validator.valid?(SecuredBy, secured_by)
      end
    end
  end
end
