# frozen_string_literal: true

require_relative "base"
require_relative "energy_consumption"
require_relative "property"

# Environmental Considerations - Describes various environmental impact metrics.
module SBOM
  module CycloneDX
    module Record
      # Schema name: EnvironmentalConsideration
      class EnvironmentalConsideration < Base
        # Energy Consumptions - Describes energy consumption information incurred for one or more component lifecycle activities.
        prop :energy_consumptions, :array, items: EnergyConsumption
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
