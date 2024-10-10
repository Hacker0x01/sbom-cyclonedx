# frozen_string_literal: true
# rbs_inline: enabled

# Postal address - An address used to identify a contactable location.
module SBOM
  module CycloneDX
    PostalAddress = SchemaObject.build("PostalAddress") do
      # BOM Reference - An optional identifier which can be used to reference the address elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

      # Country - The country name or the two-letter ISO 3166-1 country code.
      prop :country, String

      # Region - The region or state in the country.
      # Example: "Texas"
      prop :region, String

      # Locality - The locality or city within the country.
      # Example: "Austin"
      prop :locality, String

      # Post Office Box Number - The post office box number.
      # Example: 901
      prop :post_office_box_number, String

      # Postal Code - The postal code.
      # Example: "78758"
      prop :postal_code, String

      # Street Address - The street address.
      # Example: "100 Main Street"
      prop :street_address, String
    end
  end
end
