# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Organizational Entity
module SBOM
  module CycloneDX
    class OrganizationalEntity < Struct.new(
      "OrganizationalEntity",
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Organization Name - The name of the organization
      # Example: "Example Inc."
      :name,
      # Organization Address - The physical address (location) of the organization
      :address,
      # Organization URL(s) - The URL of the organization. Multiple URLs are allowed.
      :url,
      # Organizational Contact - A contact at the organization. Multiple contacts are allowed.
      :contact,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def valid?
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(String, name) &&
          Validator.valid?(PostalAddress, address) &&
          Validator.valid?(Array, url, items: URI) &&
          Validator.valid?(Array, contact, items: OrganizationalContact)
      end
    end
  end
end
