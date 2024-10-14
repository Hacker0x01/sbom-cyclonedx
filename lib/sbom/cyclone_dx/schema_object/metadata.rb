# frozen_string_literal: true

require_relative "../enum"
require_relative "../schema_object"

# BOM Metadata
module SBOM
  module CycloneDX
    class Metadata < Struct.new(
      "Metadata",
      # Timestamp - The date and time (timestamp) when the BOM was created.
      :timestamp,
      # Lifecycles - Lifecycles communicate the stage(s) in which data in the BOM was captured. Different types of data may be available at various phases of a lifecycle, such as the Software Development Lifecycle (SDLC), IT Asset Management (ITAM), and Software Asset Management (SAM). Thus, a BOM may include data specific to or only obtainable in a given lifecycle.
      :lifecycles,
      # Tools - The tool(s) used in the creation, enrichment, and validation of the BOM.
      :tools,
      # BOM Manufacturer - The organization that created the BOM. Manufacturer is common in BOMs created through automated processes. BOMs created through manual means may have `@.authors` instead.
      :manufacturer,
      # BOM Authors - The person(s) who created the BOM. Authors are common in BOMs created through manual processes. BOMs created through automated means may have `@.manufacturer` instead.
      :authors,
      # Component - The component that the BOM describes.
      :component,
      # Component Manufacture (legacy) - [Deprecated] This will be removed in a future version. Use the `@.component.manufacturer` instead. The organization that manufactured the component that the BOM describes.
      :manufacture,
      # Supplier -  The organization that supplied the component that the BOM describes. The supplier may often be the manufacturer, but may also be a distributor or repackager.
      :supplier,
      # BOM License(s) - The license information for the BOM document. This may be different from the license(s) of the component(s) that the BOM describes.
      :licenses,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(DateTime, timestamp) &&
          Validator.valid?(Array, lifecycles, items: [Union, klasses: [PreDefinedPhase, CustomPhase]]) &&
          Validator.valid?(Tools, tools) &&
          Validator.valid?(OrganizationalEntity, manufacturer) &&
          Validator.valid?(Array, authors, items: OrganizationalContact) &&
          Validator.valid?(Component, component) &&
          Validator.valid?(OrganizationalEntity, manufacture) &&
          Validator.valid?(OrganizationalEntity, supplier) &&
          Validator.valid?(Array, licenses, items: ->(item) { LicenseChoice.valid?(item, required: true) }) &&
          Validator.valid?(Array, properties, items: Property)
      end

      class CustomPhase < Struct.new(
        "CustomPhase",
        # Name - The name of the lifecycle phase
        :name,
        # Description - The description of the lifecycle phase
        :description,
        keyword_init: true
      )
        include SchemaObject

        def initialize(name:, description: nil)
          super(name: name, description: description)
        end

        def valid?
          Validator.valid?(String, name, required: true) &&
            Validator.valid?(String, description)
        end
      end

      class PreDefinedPhase < Struct.new(
        "PreDefinedPhase",
        # Phase - A pre-defined phase in the product lifecycle.
        :phase,
        keyword_init: true
      )
        include SchemaObject

        def initialize(phase:)
          super(phase: phase)
        end

        def valid?
          Validator.valid?(String, phase, enum: Enum::PHASE, required: true)
        end
      end
    end
  end
end
