# frozen_string_literal: true

require_relative "../../../email_address_extension"
require_relative "../pattern"
require_relative "base"

# Organizational Contact
module SBOM
  module CycloneDX
    module Record
      # Schema name: OrganizationalContact
      class OrganizationalContact < Base
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Name - The name of a contact
        # Example: "Contact name"
        prop :name, :string
        # Email Address - The email address of the contact.
        prop :email, :email_address
        # Phone - The phone number of the contact.
        # Example: "800-555-1212"
        prop :phone, :string
      end
    end
  end
end
