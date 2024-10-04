# frozen_string_literal: true
# rbs_inline: enabled

# Energy Measure - A measure of energy.
module SBOM
  module CycloneDX
    EnergyMeasure = SchemaObject.build("EnergyMeasure") do
      # Value - Quantity of energy.
      prop :value, Float, required: true

      # Unit - Unit of energy.
      prop :unit, String, required: true, const: true, default: "kWh"
    end
  end
end
