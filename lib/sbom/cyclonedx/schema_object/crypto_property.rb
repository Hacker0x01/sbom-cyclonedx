# frozen_string_literal: true
# rbs_inline: enabled

# Cryptographic Properties - Cryptographic assets have properties that uniquely define them and that make them actionable for further reasoning. As an example, it makes a difference if one knows the algorithm family (e.g. AES) or the specific variant or instantiation (e.g. AES-128-GCM). This is because the security level and the algorithm primitive (authenticated encryption) are only defined by the definition of the algorithm variant. The presence of a weak cryptographic algorithm like SHA1 vs. HMAC-SHA1 also makes a difference.
module Sbom
  module Cyclonedx
    class CryptoProperty < SchemaObject
      # Asset Type - Cryptographic assets occur in several forms. Algorithms and protocols are most commonly implemented in specialized cryptographic libraries. They may, however, also be 'hardcoded' in software components. Certificates and related cryptographic material like keys, tokens, secrets or passwords are other cryptographic assets to be modelled.
      attr_accessor :asset_type #: AssetType

      # Algorithm Properties - Additional properties specific to a cryptographic algorithm.
      attr_accessor :algorithm_properties #: AlgorithmProperties

      # Certificate Properties - Properties for cryptographic assets of asset type 'certificate'
      attr_accessor :certificate_properties #: CertificateProperty

      # Related Cryptographic Material Properties - Properties for cryptographic assets of asset type: `related-crypto-material`
      attr_accessor :related_crypto_material_properties #: RelatedCryptoMaterialProperties

      # Protocol Properties - Properties specific to cryptographic assets of type: `protocol`.
      attr_accessor :protocol_properties #: ProtocolProperties

      # OID - The object identifier (OID) of the cryptographic asset.
      attr_accessor :oid #: String
    end
  end
end
