# frozen_string_literal: true
# rbs_inline: enabled

# BOM Metadata
module SBOM
  module Cyclonedx
    class Metadata < SchemaObject
      # Timestamp - The date and time (timestamp) when the BOM was created.
      attr_accessor :timestamp #: DateTime

      # Lifecycles - Lifecycles communicate the stage(s) in which data in the BOM was captured. Different types of data may be available at various phases of a lifecycle, such as the Software Development Lifecycle (SDLC), IT Asset Management (ITAM), and Software Asset Management (SAM). Thus, a BOM may include data specific to or only obtainable in a given lifecycle.
      attr_accessor :lifecycles #: [PreDefinedPhase | CustomPhase]

      # Tools - The tool(s) used in the creation, enrichment, and validation of the BOM.
      attr_accessor :tools #: Tools

      # BOM Manufacturer - The organization that created the BOM. Manufacturer is common in BOMs created through automated processes. BOMs created through manual means may have `@.authors` instead.
      attr_accessor :manufacturer #: OrganizationalEntity

      # BOM Authors - The person(s) who created the BOM. Authors are common in BOMs created through manual processes. BOMs created through automated means may have `@.manufacturer` instead.
      attr_accessor :authors #: [OrganizationalContact]

      # Component - The component that the BOM describes.
      attr_accessor :component #: Component

      # Component Manufacture (legacy) - [Deprecated] This will be removed in a future version. Use the `@.component.manufacturer` instead. The organization that manufactured the component that the BOM describes.
      attr_accessor :manufacture #: OrganizationalEntity

      # Supplier -  The organization that supplied the component that the BOM describes. The supplier may often be the manufacturer, but may also be a distributor or repackager.
      attr_accessor :supplier #: OrganizationalEntity

      # BOM License(s) - The license information for the BOM document. This may be different from the license(s) of the component(s) that the BOM describes.
      attr_accessor :licenses #: [[WrappedLicense] | [LicenseExpression]]

      validate :licenses, lambda { |value|
        value.nil? || value.all? { |v| v.all?(WrappedLicense) || (v.first.is_a?(LicenseExpression) && v.length == 1) }
      }

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]

      class CustomPhase < SchemaObject
        # Name - The name of the lifecycle phase
        attr_accessor :name #: String

        validate :name, required: true

        # Description - The description of the lifecycle phase
        attr_accessor :description #: String
      end

      class PreDefinedPhase < SchemaObject
        # Phase - A pre-defined phase in the product lifecycle.
        attr_accessor :phase #: Phase

        validate :phase, required: true
      end
    end
  end
end
