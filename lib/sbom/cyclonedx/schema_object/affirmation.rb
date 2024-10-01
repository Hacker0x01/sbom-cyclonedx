# frozen_string_literal: true
# rbs_inline: enabled

# Affirmation - A concise statement affirmed by an individual regarding all declarations, often used for third-party auditor acceptance or recipient acknowledgment. It includes a list of authorized signatories who assert the validity of the document on behalf of the organization.
module SBOM
  module Cyclonedx
    class Affirmation < SchemaObject
      # Statement - The brief statement affirmed by an individual regarding all declarations.\n*- Notes This could be an affirmation of acceptance by a third-party auditor or receiving individual of a file.
      # Example: "I certify, to the best of my knowledge, that all information is correct."
      attr_accessor :statement #: String

      # Signatories - The list of signatories authorized on behalf of an organization to assert validity of this document.
      attr_accessor :signatories #: [Signatory]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature

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
end
