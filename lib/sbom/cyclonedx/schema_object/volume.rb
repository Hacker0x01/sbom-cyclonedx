# frozen_string_literal: true
# rbs_inline: enabled

# Volume - An identifiable, logical unit of data storage tied to a physical device.
module Sbom
  module Cyclonedx
    class Volume < SchemaObject
      # Unique Identifier (UID) - The unique identifier for the volume instance within its deployment context.
      attr_accessor :uid #: String

      # Name - The name of the volume instance
      attr_accessor :name #: String

      # Mode - The mode for the volume instance.
      attr_accessor :mode #: VolumeMode

      # Path - The underlying path created from the actual volume.
      attr_accessor :path #: String

      # Size allocated - The allocated size of the volume accessible to the associated workspace. This should include the scalar size as well as IEC standard unit in either decimal or binary form.
      # Examples: "10GB", "2Ti", "1Pi"
      attr_accessor :size_allocated #: String

      # Persistent - Indicates if the volume persists beyond the life of the resource it is associated with.
      attr_accessor :persistent #: bool

      # Remote - Indicates if the volume is remotely (i.e., network) attached.
      attr_accessor :remote #: bool

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]

      default :mode, VolumeMode::FILESYSTEM
    end
  end
end
