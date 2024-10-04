# frozen_string_literal: true
# rbs_inline: enabled

# Volume - An identifiable, logical unit of data storage tied to a physical device.
module SBOM
  module CycloneDX
    Volume = SchemaObject.build("Volume") do
      # Unique Identifier (UID) - The unique identifier for the volume instance within its deployment context.
      prop :uid, String

      # Name - The name of the volume instance
      prop :name, String

      # Mode - The mode for the volume instance.
      prop :mode, String, enum: Enum::VOLUME_MODE

      # Path - The underlying path created from the actual volume.
      prop :path, String

      # Size allocated - The allocated size of the volume accessible to the associated workspace. This should include the scalar size as well as IEC standard unit in either decimal or binary form.
      # Examples: "10GB", "2Ti", "1Pi"
      prop :size_allocated, String

      # Persistent - Indicates if the volume persists beyond the life of the resource it is associated with.
      prop :persistent, :bool

      # Remote - Indicates if the volume is remotely (i.e., network) attached.
      prop :remote, :bool

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      prop :properties, [Property], default: VolumeMode::FILESYSTEM
    end
  end
end
