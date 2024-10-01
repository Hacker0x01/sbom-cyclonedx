# frozen_string_literal: true
# rbs_inline: enabled

# Organizational Entity
module SBOM
  module Cyclonedx
    class OrganizationalEntity < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Organization Name - The name of the organization
      # Example: "Example Inc."
      attr_accessor :name #: String

      # Organization Address - The physical address (location) of the organization
      attr_accessor :address #: PostalAddress

      # Organization URL(s) - The URL of the organization. Multiple URLs are allowed.
      attr_accessor :url #: [URI]

      # Organizational Contact - A contact at the organization. Multiple contacts are allowed.
      attr_accessor :contact #: [OrganizationalContact]
    end
  end
end
