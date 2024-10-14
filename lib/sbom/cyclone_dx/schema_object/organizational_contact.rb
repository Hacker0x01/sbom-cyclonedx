# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"

# Organizational Contact
module SBOM
  module CycloneDX
    class OrganizationalContact < Struct.new(
      "OrganizationalContact",
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Name - The name of a contact
      # Example: "Contact name"
      :name,
      # Email Address - The email address of the contact.
      :email,
      # Phone - The phone number of the contact.
      # Example: "800-555-1212"
      :phone,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def valid?
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(String, name) &&
          Validator.valid?(EmailAddress::Address, email) &&
          Validator.valid?(String, phone)
      end
    end
  end
end
