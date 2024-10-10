# frozen_string_literal: true
# rbs_inline: enabled

# Organizational Entity
module SBOM
  module CycloneDX
    OrganizationalEntity = SchemaObject.build("OrganizationalEntity") do
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

      # Organization Name - The name of the organization
      # Example: "Example Inc."
      prop :name, String

      # Organization Address - The physical address (location) of the organization
      prop :address, PostalAddress

      # Organization URL(s) - The URL of the organization. Multiple URLs are allowed.
      prop :url, [URI]

      # Organizational Contact - A contact at the organization. Multiple contacts are allowed.
      prop :contact, [OrganizationalContact]
    end
  end
end
