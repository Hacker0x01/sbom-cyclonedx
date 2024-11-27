# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"

# Postal address - An address used to identify a contactable location.
module SBOM
  module CycloneDX
    module Record
      # Schema name: PostalAddress
      class PostalAddress < Base
        # BOM Reference - An optional identifier which can be used to reference the address elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Country - The country name or the two-letter ISO 3166-1 country code.
        prop :country, :string
        # Region - The region or state in the country.
        # Example: "Texas"
        prop :region, :string
        # Locality - The locality or city within the country.
        # Example: "Austin"
        prop :locality, :string
        # Post Office Box Number - The post office box number.
        # Example: 901
        prop :post_office_box_number, :string
        # Postal Code - The postal code.
        # Example: "78758"
        prop :postal_code, :string
        # Street Address - The street address.
        # Example: "100 Main Street"
        prop :street_address, :string
      end
    end
  end
end
