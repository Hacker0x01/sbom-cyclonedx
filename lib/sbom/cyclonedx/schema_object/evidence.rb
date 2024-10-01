# frozen_string_literal: true
# rbs_inline: enabled

module SBOM
  module Cyclonedx
    class Evidence < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
      attr_accessor :bom_ref #: RefLink

      # Property Name - The reference to the property name as defined in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy/).
      attr_accessor :property_name #: String

      # Description - The written description of what this evidence is and how it was created.
      attr_accessor :description #: String

      # Data - The output or analysis that supports claims.
      attr_accessor :data #: [EvidenceData]

      # Created - The date and time (timestamp) when the evidence was created.
      attr_accessor :created #: DateTime

      # Expires - The optional date and time (timestamp) when the evidence is no longer valid.
      attr_accessor :expires #: DateTime

      # Author - The author of the evidence.
      attr_accessor :author #: OrganizationalContact

      # Reviewer - The reviewer of the evidence.
      attr_accessor :reviewer #: OrganizationalContact

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature
    end
  end
end
