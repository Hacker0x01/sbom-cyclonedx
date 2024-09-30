# frozen_string_literal: true
# rbs_inline: enabled

# Postal address - An address used to identify a contactable location.
module Sbom
  module Cyclonedx
    class PostalAddress < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the address elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Country - The country name or the two-letter ISO 3166-1 country code.
      attr_accessor :country #: String

      # Region - The region or state in the country.
      # Example: "Texas"
      attr_accessor :region #: String

      # Locality - The locality or city within the country.
      # Example: "Austin"
      attr_accessor :locality #: String

      # Post Office Box Number - The post office box number.
      # Example: 901
      attr_accessor :post_office_box_number #: String

      # Postal Code - The postal code.
      # Example: "78758"
      attr_accessor :postal_code #: String

      # Street Address - The street address.
      # Example: "100 Main Street"
      attr_accessor :street_address #: String
    end
  end
end
