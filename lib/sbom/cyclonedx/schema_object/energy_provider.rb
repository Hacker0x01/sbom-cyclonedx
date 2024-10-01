# frozen_string_literal: true
# rbs_inline: enabled

# Energy Provider - Describes the physical provider of energy used for model development or operations.
module SBOM
  module Cyclonedx
    class EnergyProvider < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the energy provider elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Description - A description of the energy provider.
      attr_accessor :description #: String

      # Organization - The organization that provides energy.
      attr_accessor :organization #: OrganizationalEntity

      validate :organization, required: true

      # Energy Source - The energy source for the energy provider.
      attr_accessor :energy_source #: EnergySource

      validate :energy_source, required: true

      # Energy Provided - The energy provided by the energy source for an associated activity.
      attr_accessor :energy_provided #: EnergyMeasure

      validate :energy_provided, required: true

      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      attr_accessor :external_references #: [ExternalReference]
    end
  end
end
