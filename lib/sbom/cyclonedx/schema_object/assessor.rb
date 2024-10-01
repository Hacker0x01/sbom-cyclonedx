# frozen_string_literal: true
# rbs_inline: enabled

# CycloneDX Bill of Materials Standard
module SBOM
  module Cyclonedx
    class Root < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
      attr_accessor :bom_ref #: RefLink

      # Third Party - The boolean indicating if the assessor is outside the organization generating claims. A value of false indicates a self assessor.
      attr_accessor :third_party #: Boolean

      # Organization - The entity issuing the assessment.
      attr_accessor :organization #: OrganizationalEntity
    end
  end
end
