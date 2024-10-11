# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Energy consumption - Describes energy consumption information incurred for the specified lifecycle activity.
module SBOM
  module CycloneDX
    class EnergyConsumption < Struct.new(
      "EnergyConsumption",
      # Activity - The type of activity that is part of a machine learning model development or operational lifecycle.
      # prop :activity, String, enum: Enum::ACTIVITY, required: true
      :activity,
      # Energy Providers - The provider(s) of the energy consumed by the associated model development lifecycle activity.
      # prop :energy_providers, [EnergyProvider], required: true
      :energy_providers,
      # Activity Energy Cost - The total energy cost associated with the model lifecycle activity.
      # prop :activity_energy_cost, EnergyMeasure, required: true
      :activity_energy_cost,
      # CO2 Equivalent Cost - The CO2 cost (debit) equivalent to the total energy cost.
      # prop :co2_cost_equivalent, CO2Measure
      :co2_cost_equivalent,
      # CO2 Cost Offset - The CO2 offset (credit) for the CO2 equivalent cost.
      # prop :co2_cost_offset, CO2Measure
      :co2_cost_offset,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      # prop :properties, [Property]
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def initialize( # rubocop:disable Metrics/ParameterLists
        activity:,
        energy_providers:,
        activity_energy_cost:,
        co2_cost_equivalent: nil,
        co2_cost_offset: nil,
        properties: nil
      )
        super
      end

      def valid?
        Validator.valid?(String, activity, required: true, enum: Enum::ACTIVITY) &&
          Validator.valid?(Array, energy_providers, required: true, items: EnergyProvider) &&
          Validator.valid?(EnergyMeasure, activity_energy_cost, required: true) &&
          Validator.valid?(CO2Measure, co2_cost_equivalent) &&
          Validator.valid?(CO2Measure, co2_cost_offset) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
