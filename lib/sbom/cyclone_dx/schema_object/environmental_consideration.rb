# frozen_string_literal: true

require_relative "../schema_object"

# Environmental Considerations - Describes various environmental impact metrics.
module SBOM
  module CycloneDX
    class EnvironmentalConsideration < Struct.new(
      "EnvironmentalConsideration",
      # Energy Consumptions - Describes energy consumption information incurred for one or more component lifecycle activities.
      :energy_consumptions,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(Array, energy_consumptions, items: EnergyConsumption) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
