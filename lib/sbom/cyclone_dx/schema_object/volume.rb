# frozen_string_literal: true

require_relative "../enum"
require_relative "../schema_object"

# Volume - An identifiable, logical unit of data storage tied to a physical device.
module SBOM
  module CycloneDX
    class Volume < Struct.new(
      "Volume",
      # Unique Identifier (UID) - The unique identifier for the volume instance within its deployment context.
      :uid,
      # Name - The name of the volume instance
      :name,
      # Mode - The mode for the volume instance.
      :mode,
      # Path - The underlying path created from the actual volume.
      :path,
      # Size allocated - The allocated size of the volume accessible to the associated workspace. This should include the scalar size as well as IEC standard unit in either decimal or binary form.
      # Examples: "10GB", "2Ti", "1Pi"
      :size_allocated,
      # Persistent - Indicates if the volume persists beyond the life of the resource it is associated with.
      :persistent,
      # Remote - Indicates if the volume is remotely (i.e., network) attached.
      :remote,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def initialize(
        uid: nil,
        name: nil,
        mode: "filesystem",
        path: nil,
        size_allocated: nil,
        persistent: nil,
        remote: nil,
        properties: nil
      )
        super
      end

      def valid?
        Validator.valid?(String, uid) &&
          Validator.valid?(String, name) &&
          Validator.valid?(String, mode, enum: Enum::VOLUME_MODE) &&
          Validator.valid?(String, path) &&
          Validator.valid?(String, size_allocated) &&
          Validator.valid?(SBOM::CycloneDX::Type::Boolean, persistent) &&
          Validator.valid?(SBOM::CycloneDX::Type::Boolean, remote) &&
          Validator.valid?(Array, properties, of: Property)
      end
    end
  end
end
