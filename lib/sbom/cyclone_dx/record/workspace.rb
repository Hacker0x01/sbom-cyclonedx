# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "resource_reference_choice"
require_relative "property"
require_relative "volume"

# Workspace - A named filesystem or data resource shareable by workflow tasks.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Workspace
      class Workspace < Base
        # BOM Reference - An optional identifier which can be used to reference the workspace elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref", required: true
        # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
        prop :uid, :string, required: true
        # Name - The name of the resource instance.
        prop :name, :string
        # Aliases - The names for the workspace as referenced by other workflow tasks. Effectively, a name mapping so other tasks can use their own local name in their steps.
        prop :aliases, :array, items: :string
        # Description - A description of the resource instance.
        prop :description, :string
        # Resource references - References to component or service resources that are used to realize the resource instance.
        prop :resource_references, :array, items: ResourceReferenceChoice, unique: true
        # Access mode - Describes the read-write access control for the workspace relative to the owning resource instance.
        prop :access_mode, :string, enum: Enum::ACCESS_MODE
        # Mount path - A path to a location on disk where the workspace will be available to the associated task's steps.
        prop :mount_path, :string
        # Managed data type - The name of a domain-specific data type the workspace represents.
        # Examples: "ConfigMap", "Secret"
        prop :managed_data_type, :string
        # Volume request - Identifies the reference to the request for a specific volume type and parameters.
        # Example: "a kubernetes Persistent Volume Claim (PVC) name"
        prop :volume_request, :string
        # Volume - Information about the actual volume instance allocated to the workspace.
        prop :volume, Volume
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
