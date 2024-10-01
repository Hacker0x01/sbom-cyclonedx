# frozen_string_literal: true
# rbs_inline: enabled

# Signatory - A person or organization authorized on behalf of an organization to assert validity of this document.
module Sbom
  module Cyclonedx
    class Signatory < SchemaObject
      # Name - The signatory's name.
      attr_accessor :name #: String

      # Role - The signatory's role within an organization.
      attr_accessor :role #: String

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature

      validate :signature, required: -> { external_reference.nil? || organization.nil? }

      # Organization - The signatory's organization.
      attr_accessor :organization #: OrganizationalEntity

      validate :organization, required: -> { signature.nil? }

      # External Reference - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      attr_accessor :external_reference #: ExternalReference

      validate :external_reference, required: -> { signature.nil? }
    end
  end
end
