# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "external_reference"
require_relative "energy_measure"
require_relative "organizational_entity"

# Energy Provider - Describes the physical provider of energy used for model development or operations.
module SBOM
  module CycloneDX
    module Record
      # Schema name: EnergyProvider
      class EnergyProvider < Base
        # BOM Reference - An optional identifier which can be used to reference the energy provider elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Description - A description of the energy provider.
        prop :description, :string
        # Organization - The organization that provides energy.
        prop :organization, OrganizationalEntity, required: true
        # Energy Source - The energy source for the energy provider.
        prop :energy_source, :string, enum: Enum::ENERGY_SOURCE, required: true
        # Energy Provided - The energy provided by the energy source for an associated activity.
        prop :energy_provided, EnergyMeasure, required: true
        # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
        prop :external_references, :array, items: ExternalReference
      end
    end
  end
end
