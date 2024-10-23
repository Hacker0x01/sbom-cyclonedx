# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"
require_relative "external_reference"
require_relative "energy_measure"
require_relative "organizational_entity"

# Energy Provider - Describes the physical provider of energy used for model development or operations.
module SBOM
  module CycloneDX
    class EnergyProvider < Struct.new(
      "EnergyProvider",
      # BOM Reference - An optional identifier which can be used to reference the energy provider elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Description - A description of the energy provider.
      :description,
      # Organization - The organization that provides energy.
      :organization,
      # Energy Source - The energy source for the energy provider.
      :energy_source,
      # Energy Provided - The energy provided by the energy source for an associated activity.
      :energy_provided,
      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      :external_references,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def initialize(
        organization:,
        energy_source:,
        energy_provided:,
        bom_ref: nil,
        description: nil,
        external_references: nil
      )
        super
      end

      def valid?
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(String, description) &&
          Validator.valid?(OrganizationalEntity, organization, required: true) &&
          Validator.valid?(String, energy_source, enum: Enum::ENERGY_SOURCE, required: true) &&
          Validator.valid?(EnergyMeasure, energy_provided, required: true) &&
          Validator.valid?(Array, external_references, items: ExternalReference)
      end
    end
  end
end
