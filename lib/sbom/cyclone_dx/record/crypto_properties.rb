# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "cipher_suite"
require_relative "secured_by"

# Cryptographic Properties - Cryptographic assets have properties that uniquely define them and that make them actionable for further reasoning. As an example, it makes a difference if one knows the algorithm family (e.g. AES) or the specific variant or instantiation (e.g. AES-128-GCM). This is because the security level and the algorithm primitive (authenticated encryption) are only defined by the definition of the algorithm variant. The presence of a weak cryptographic algorithm like SHA1 vs. HMAC-SHA1 also makes a difference.
module SBOM
  module CycloneDX
    module Record
      # Schema name: CryptoProperties
      class CryptoProperties < Base
        # Schema name: AlgorithmProperties
        class AlgorithmProperties < Base
          # primitive - Cryptographic building blocks used in higher-level cryptographic systems and protocols. Primitives represent different cryptographic routines: deterministic random bit generators (drbg, e.g. CTR_DRBG from NIST SP800-90A-r1), message authentication codes (mac, e.g. HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20), signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key encryption schemes (pke, e.g. RSA), extended output functions (xof, e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM), authenticated encryption (ae, e.g. AES-GCM) and the combination of multiple algorithms (combiner, e.g. SP800-56Cr2).
          prop :primitive, :string, enum: Enum::PRIMITIVE
          # Parameter Set Identifier - An identifier for the parameter set of the cryptographic algorithm. Examples: in AES128, '128' identifies the key length in bits, in SHA256, '256' identifies the digest length, '128' in SHAKE128 identifies its maximum security level in bits, and 'SHA2-128s' identifies a parameter set used in SLH-DSA (FIPS205).
          prop :parameter_set_identifier, :string
          # Elliptic Curve - The specific underlying Elliptic Curve (EC) definition employed which is an indicator of the level of security strength, performance and complexity. Absent an authoritative source of curve names, CycloneDX recommends using curve names as defined at [https://neuromancer.sk/std/](https://neuromancer.sk/std/), the source of which can be found at [https://github.com/J08nY/std-curves](https://github.com/J08nY/std-curves).
          prop :curve, :string
          # Execution Environment - The target and execution environment in which the algorithm is implemented in.
          prop :execution_environment, :string, enum: Enum::EXECUTION_ENVIRONMENT
          # Implementation platform - The target platform for which the algorithm is implemented. The implementation can be 'generic', running on any platform or for a specific platform.
          prop :implementation_platform, :string, enum: Enum::IMPLEMENTATION_PLATFORM
          # Certification Level - The certification that the implementation of the cryptographic algorithm has received, if any. Certifications include revisions and levels of FIPS 140 or Common Criteria of different Extended Assurance Levels (CC-EAL).
          prop :certification_level, :array, items: [:string, enum: Enum::CERTIFICATION_LEVEL]
          # Mode - The mode of operation in which the cryptographic algorithm (block cipher) is used.
          prop :mode, :string, enum: Enum::ALGORITHM_MODE
          # Padding - The padding scheme that is used for the cryptographic algorithm.
          prop :padding, :string, enum: Enum::PADDING
          # Cryptographic functions - The cryptographic functions implemented by the cryptographic algorithm.
          prop :crypto_functions, :array, items: [:string, enum: Enum::CRYPTO_FUNCTION]
          # classical security level - The classical security level that a cryptographic algorithm provides (in bits).
          prop :classical_security_level, :integer, minimum: 0
          # NIST security strength category - The NIST security strength category as defined in https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria). A value of 0 indicates that none of the categories are met.
          prop :nist_quantum_security_level, :integer, minimum: 0, maximum: 6
        end

        # Schema name: CertificateProperties
        class CertificateProperties < Base
          # Subject Name - The subject name for the certificate
          prop :subject_name, :string
          # Issuer Name - The issuer name for the certificate
          prop :issuer_name, :string
          # Not Valid Before - The date and time according to ISO-8601 standard from which the certificate is valid
          prop :not_valid_before, :date_time
          # Not Valid After - The date and time according to ISO-8601 standard from which the certificate is not valid anymore
          prop :not_valid_after, :date_time
          # Algorithm Reference - The bom-ref to signature algorithm used by the certificate
          prop :signature_algorithm_ref, :string, pattern: Pattern::REF_LINK
          # Key reference - The bom-ref to the public key of the subject
          prop :subject_public_key_ref, :string, pattern: Pattern::REF_LINK
          # Certificate Format - The format of the certificate
          # Examples: "X.509", "PEM", "DER", "CVC"
          prop :certificate_format, :string
          # Certificate File Extension - The file extension of the certificate
          # Examples: "crt", "pem", "cer", "der", "p12"
          prop :certificate_extension, :string
        end

        # Schema name: ProtocolProperties
        class ProtocolProperties < Base
          # Schema name: IKEv2TransformType
          class IKEv2TransformType < Base
            # Encryption Algorithm (ENCR) - Transform Type 1: encryption algorithms
            prop :encr, :array, items: [:string, pattern: Pattern::REF_LINK]
            # Pseudorandom Function (PRF) - Transform Type 2: pseudorandom functions
            prop :prf, :array, items: [:string, pattern: Pattern::REF_LINK]
            # Integrity Algorithm (INTEG) - Transform Type 3: integrity algorithms
            prop :integ, :array, items: [:string, pattern: Pattern::REF_LINK]
            # Key Exchange Method (KE) - Transform Type 4: Key Exchange Method (KE) per [RFC 9370](https://www.ietf.org/rfc/rfc9370.html), formerly called Diffie-Hellman Group (D-H).
            prop :ke, :array, items: [:string, pattern: Pattern::REF_LINK]
            # Extended Sequence Numbers (ESN) - Specifies if an Extended Sequence Number (ESN) is used.
            prop :esn, :boolean
            # IKEv2 Authentication method - IKEv2 Authentication method
            prop :auth, :array, items: [:string, pattern: Pattern::REF_LINK]
          end

          # Type - The concrete protocol type.
          prop :type, :string, enum: Enum::PROTOCOL_TYPE
          # Protocol Version - The version of the protocol.
          # Examples: "1.0", "1.2", "1.99"
          prop :version, :string
          # Cipher Suites - A list of cipher suites related to the protocol.
          prop :cipher_suites, :array, items: CipherSuite
          # IKEv2 Transform Types - The IKEv2 transform types supported (types 1-4), defined in [RFC 7296 section 3.3.2](https://www.ietf.org/rfc/rfc7296.html#section-3.3.2), and additional properties.
          prop :ikev2_transform_types, IKEv2TransformType
          # Cryptographic References - A list of protocol-related cryptographic assets
          prop :crypto_ref_array, :array, items: [:string, pattern: Pattern::REF_LINK]
        end

        # Schema name: RelatedCryptoMaterialProperties
        class RelatedCryptoMaterialProperties < Base
          # relatedCryptoMaterialType - The type for the related cryptographic material
          prop :type, :string, enum: Enum::RELATED_CRYPTO_MATERIAL_TYPE
          # ID - The optional unique identifier for the related cryptographic material.
          prop :id, :string
          # State - The key state as defined by NIST SP 800-57.
          prop :state, :string, enum: Enum::RELATED_CRYPTO_MATERIAL_STATE
          # Algorithm Reference - The bom-ref to the algorithm used to generate the related cryptographic material.
          prop :algorithm_ref, :string, pattern: Pattern::REF_LINK
          # Creation Date - The date and time (timestamp) when the related cryptographic material was created.
          prop :creation_date, :date_time
          # Activation Date - The date and time (timestamp) when the related cryptographic material was activated.
          prop :activation_date, :date_time
          # Update Date - The date and time (timestamp) when the related cryptographic material was updated.
          prop :update_date, :date_time
          # Expiration Date - The date and time (timestamp) when the related cryptographic material expires.
          prop :expiration_date, :date_time
          # Value - The associated value of the cryptographic material.
          prop :value, :string
          # Size - The size of the cryptographic asset (in bits).
          prop :asset_size, :integer, json_name: "size"
          # Format - The format of the related cryptographic material (e.g. P8, PEM, DER).
          prop :format, :string
          # Secured By - The mechanism by which the cryptographic asset is secured by.
          prop :secured_by, SecuredBy
        end

        # Asset Type - Cryptographic assets occur in several forms. Algorithms and protocols are most commonly implemented in specialized cryptographic libraries. They may, however, also be 'hardcoded' in software components. Certificates and related cryptographic material like keys, tokens, secrets or passwords are other cryptographic assets to be modelled.
        prop :asset_type, :string, enum: Enum::ASSET_TYPE, required: true
        # Algorithm Properties - Additional properties specific to a cryptographic algorithm.
        prop :algorithm_properties, AlgorithmProperties
        # Certificate Properties - Properties for cryptographic assets of asset type 'certificate'
        prop :certificate_properties, CertificateProperties
        # Related Cryptographic Material Properties - Properties for cryptographic assets of asset type: `related-crypto-material`
        prop :related_crypto_material_properties, RelatedCryptoMaterialProperties
        # Protocol Properties - Properties specific to cryptographic assets of type: `protocol`.
        prop :protocol_properties, ProtocolProperties
        # OID - The object identifier (OID) of the cryptographic asset.
        prop :oid, :string
      end
    end
  end
end
