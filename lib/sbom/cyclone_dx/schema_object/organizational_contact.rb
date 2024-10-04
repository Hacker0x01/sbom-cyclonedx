# frozen_string_literal: true
# rbs_inline: enabled

# Organizational Contact
module SBOM
  module CycloneDX
    OrganizationalContact = SchemaObject.build("OrganizationalContact") do
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_name: "bom-ref", pattern: Pattern::REF_LINK

      # Name - The name of a contact
      # Example: "Contact name"
      prop :name, String

      # Email Address - The email address of the contact.
      prop :email, URI

      # Phone - The phone number of the contact.
      # Example: "800-555-1212"
      prop :phone, String
    end
  end
end
