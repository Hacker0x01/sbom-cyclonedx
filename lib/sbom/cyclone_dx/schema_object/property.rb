# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Lightweight name-value pair - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
module SBOM
  module CycloneDX
    class Property < Struct.new(
      "Property",
      # Name - The name of the property. Duplicate names are allowed, each potentially having a different value.
      # prop :name, String, required: true
      :name,
      # Value - The value of the property.
      # prop :value, String
      :value,
      keyword_init: true
    )
      include SchemaObject

      def initialize(name:, value: nil)
        super
      end

      def valid?
        Validator.valid?(String, name, required: true) &&
          Validator.valid?(String, value)
      end
    end
  end
end
