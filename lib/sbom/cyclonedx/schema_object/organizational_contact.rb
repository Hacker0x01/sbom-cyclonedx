# frozen_string_literal: true
# rbs_inline: enabled

# Organizational Contact
module SBOM
  module Cyclonedx
    class OrganizationalContact < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Name - The name of a contact
      # Example: "Contact name"
      attr_accessor :name #: String

      # Email Address - The email address of the contact.
      attr_accessor :email #: URI

      # Phone - The phone number of the contact.
      # Example: "800-555-1212"
      attr_accessor :phone #: String
    end
  end
end
