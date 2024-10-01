# frozen_string_literal: true
# rbs_inline: enabled

# Workspace - A named filesystem or data resource shareable by workflow tasks.
module SBOM
  module Cyclonedx
    class Workspace < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the workspace elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      validate :bom_ref, required: true

      # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
      attr_accessor :uid #: String

      validate :uid, required: true

      # Name - The name of the resource instance.
      attr_accessor :name #: String

      # Aliases - The names for the workspace as referenced by other workflow tasks. Effectively, a name mapping so other tasks can use their own local name in their steps.
      attr_accessor :aliases #: [String]

      # Description - A description of the resource instance.
      attr_accessor :description #: String

      # Resource references - References to component or service resources that are used to realize the resource instance.
      attr_accessor :resource_references #: Set[ResourceReferenceChoice]

      # Access mode - Describes the read-write access control for the workspace relative to the owning resource instance.
      attr_accessor :access_mode #: AccessMode

      # Mount path - A path to a location on disk where the workspace will be available to the associated task's steps.
      attr_accessor :mount_path #: String

      # Managed data type - The name of a domain-specific data type the workspace represents.
      # Examples: "ConfigMap", "Secret"
      attr_accessor :managed_data_type #: String

      # Volume request - Identifies the reference to the request for a specific volume type and parameters.
      # Example: "a kubernetes Persistent Volume Claim (PVC) name"
      attr_accessor :volume_request #: String

      # Volume - Information about the actual volume instance allocated to the workspace.
      attr_accessor :volume #: Volume

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
