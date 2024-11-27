# frozen_string_literal: true

require_relative "../enum"
require_relative "base"
require_relative "property"

# Volume - An identifiable, logical unit of data storage tied to a physical device.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Volume
      class Volume < Base
        # Unique Identifier (UID) - The unique identifier for the volume instance within its deployment context.
        prop :uid, :string
        # Name - The name of the volume instance
        prop :name, :string
        # Mode - The mode for the volume instance.
        prop :mode, :string, enum: Enum::VOLUME_MODE, default: "filesystem"
        # Path - The underlying path created from the actual volume.
        prop :path, :string
        # Size allocated - The allocated size of the volume accessible to the associated workspace. This should include the scalar size as well as IEC standard unit in either decimal or binary form.
        # Examples: "10GB", "2Ti", "1Pi"
        prop :size_allocated, :string
        # Persistent - Indicates if the volume persists beyond the life of the resource it is associated with.
        prop :persistent, :boolean
        # Remote - Indicates if the volume is remotely (i.e., network) attached.
        prop :remote, :boolean
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
