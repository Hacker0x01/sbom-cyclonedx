# frozen_string_literal: true

require_relative "organizational_contact"
require_relative "postal_address"
require_relative "../pattern"
require_relative "base"

# Organizational Entity
module SBOM
  module CycloneDX
    module Record
      # Schema name: OrganizationalEntity
      class OrganizationalEntity < Base
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Organization Name - The name of the organization
        # Example: "Example Inc."
        prop :name, :string
        # Organization Address - The physical address (location) of the organization
        prop :address, PostalAddress
        # Organization URL(s) - The URL of the organization. Multiple URLs are allowed.
        prop :url, :array, items: :uri
        # Organizational Contact - A contact at the organization. Multiple contacts are allowed.
        prop :contact, :array, items: OrganizationalContact
      end
    end
  end
end
