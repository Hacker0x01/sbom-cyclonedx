# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Postal address - An address used to identify a contactable location.
module SBOM
  module CycloneDX
    class PostalAddress < Struct.new(
      "PostalAddress",
      # BOM Reference - An optional identifier which can be used to reference the address elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Country - The country name or the two-letter ISO 3166-1 country code.
      :country,
      # Region - The region or state in the country.
      # Example: "Texas"
      :region,
      # Locality - The locality or city within the country.
      # Example: "Austin"
      :locality,
      # Post Office Box Number - The post office box number.
      # Example: 901
      :post_office_box_number,
      # Postal Code - The postal code.
      # Example: "78758"
      :postal_code,
      # Street Address - The street address.
      # Example: "100 Main Street"
      :street_address,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def valid?
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(String, country) &&
          Validator.valid?(String, region) &&
          Validator.valid?(String, locality) &&
          Validator.valid?(String, post_office_box_number) &&
          Validator.valid?(String, postal_code) &&
          Validator.valid?(String, street_address)
      end
    end
  end
end
