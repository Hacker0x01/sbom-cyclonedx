# frozen_string_literal: true
# rbs_inline: enabled

# CO2 Measure - A measure of carbon dioxide (CO2).
module SBOM
  module CycloneDX
    CO2Measure = SchemaObject.build("CO2Measure") do
      # Value - Quantity of carbon dioxide (CO2).
      prop :value, Float, required: true

      # Unit - Unit of carbon dioxide (CO2).
      prop :unit, String, required: true, const: true, default: "tCO2eq"
    end
  end
end
