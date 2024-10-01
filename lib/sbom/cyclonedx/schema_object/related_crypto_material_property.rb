# frozen_string_literal: true
# rbs_inline: enabled

# Related Cryptographic Material Properties - Properties for cryptographic assets of asset type: `related-crypto-material`
module SBOM
  module Cyclonedx
    class RelatedCryptoMaterialProperties < SchemaObject
      # relatedCryptoMaterialType - The type for the related cryptographic material
      attr_accessor :type #: RelatedCryptoMaterialType

      # ID - The optional unique identifier for the related cryptographic material.
      attr_accessor :id #: String

      # State - The key state as defined by NIST SP 800-57.
      attr_accessor :state #: RelatedCryptoMaterialState

      # Algorithm Reference - The bom-ref to the algorithm used to generate the related cryptographic material.
      attr_accessor :algorithm_ref #: RefLink

      # Creation Date - The date and time (timestamp) when the related cryptographic material was created.
      attr_accessor :creation_date #: DateTime

      # Activation Date - The date and time (timestamp) when the related cryptographic material was activated.
      attr_accessor :activation_date #: DateTime

      # Update Date - The date and time (timestamp) when the related cryptographic material was updated.
      attr_accessor :update_date #: DateTime

      # Expiration Date - The date and time (timestamp) when the related cryptographic material expires.
      attr_accessor :expiration_date #: DateTime

      # Value - The associated value of the cryptographic material.
      attr_accessor :value #: String

      # Size - The size of the cryptographic asset (in bits).
      attr_accessor :size #: Integer

      # Format - The format of the related cryptographic material (e.g. P8, PEM, DER).
      attr_accessor :format #: String

      # Secured By - The mechanism by which the cryptographic asset is secured by.
      attr_accessor :secured_by #: SecuredBy
    end
  end
end
