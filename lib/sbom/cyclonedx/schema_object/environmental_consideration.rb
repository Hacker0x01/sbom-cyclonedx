# frozen_string_literal: true
# rbs_inline: enabled

# Environmental Considerations - Describes various environmental impact metrics.
module SBOM
  module Cyclonedx
    class EnvironmentalConsideration < SchemaObject
      # Energy Consumptions - Describes energy consumption information incurred for one or more component lifecycle activities.
      attr_accessor :energy_consumptions #: [EnergyConsumption]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
