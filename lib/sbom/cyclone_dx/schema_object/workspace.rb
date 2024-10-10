# frozen_string_literal: true
# rbs_inline: enabled

# Workspace - A named filesystem or data resource shareable by workflow tasks.
module SBOM
  module CycloneDX
    Workspace = SchemaObject.build("Workspace") do
      # BOM Reference - An optional identifier which can be used to reference the workspace elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK, required: true

      # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
      prop :uid, String, required: true

      # Name - The name of the resource instance.
      prop :name, String

      # Aliases - The names for the workspace as referenced by other workflow tasks. Effectively, a name mapping so other tasks can use their own local name in their steps.
      prop :aliases, [String]

      # Description - A description of the resource instance.
      prop :description, String

      # Resource references - References to component or service resources that are used to realize the resource instance.
      prop :resource_references, Set[ResourceReferenceChoice]

      # Access mode - Describes the read-write access control for the workspace relative to the owning resource instance.
      prop :access_mode, String, enum: Enum::ACCESS_MODE

      # Mount path - A path to a location on disk where the workspace will be available to the associated task's steps.
      prop :mount_path, String

      # Managed data type - The name of a domain-specific data type the workspace represents.
      # Examples: "ConfigMap", "Secret"
      prop :managed_data_type, String

      # Volume request - Identifies the reference to the request for a specific volume type and parameters.
      # Example: "a kubernetes Persistent Volume Claim (PVC) name"
      prop :volume_request, String

      # Volume - Information about the actual volume instance allocated to the workspace.
      prop :volume, Volume

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      prop :properties, [Property]
    end
  end
end
