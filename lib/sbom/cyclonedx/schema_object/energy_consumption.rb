# frozen_string_literal: true
# rbs_inline: enabled

# Energy consumption - Describes energy consumption information incurred for the specified lifecycle activity.
module SBOM
  module Cyclonedx
    class EnergyConsumption < SchemaObject
      # Activity - The type of activity that is part of a machine learning model development or operational lifecycle.
      attr_accessor :activity #: Activity

      # Energy Providers - The provider(s) of the energy consumed by the associated model development lifecycle activity.
      attr_accessor :energy_providers #: [EnergyProvider]

      # Activity Energy Cost - The total energy cost associated with the model lifecycle activity.
      attr_accessor :activity_energy_cost #: EnergyMeasure

      # CO2 Equivalent Cost - The CO2 cost (debit) equivalent to the total energy cost.
      attr_accessor :co2_cost_equivalent #: Co2Measure

      # CO2 Cost Offset - The CO2 offset (credit) for the CO2 equivalent cost.
      attr_accessor :co2_cost_offset #: Co2Measure

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
