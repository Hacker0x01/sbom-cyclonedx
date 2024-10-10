# frozen_string_literal: true
# rbs_inline: enabled

# Energy Provider - Describes the physical provider of energy used for model development or operations.
module SBOM
  module CycloneDX
    EnergyProvider = SchemaObject.build("EnergyProvider") do
      # BOM Reference - An optional identifier which can be used to reference the energy provider elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

      # Description - A description of the energy provider.
      prop :description, String

      # Organization - The organization that provides energy.
      prop :organization, OrganizationalEntity, required: true

      # Energy Source - The energy source for the energy provider.
      prop :energy_source, String, enum: Enum::ENERGY_SOURCE, required: true

      # Energy Provided - The energy provided by the energy source for an associated activity.
      prop :energy_provided, EnergyMeasure, required: true

      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      prop :external_references, [ExternalReference]
    end
  end
end
