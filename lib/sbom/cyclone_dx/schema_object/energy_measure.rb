# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Energy Measure - A measure of energy.
module SBOM
  module CycloneDX
    class EnergyMeasure < Struct.new(
      "EnergyMeasure",
      # Value - Quantity of energy.
      :value,
      # Unit - Unit of energy, currently specified as a const "kWh".
      :unit,
      keyword_init: true
    )
      include SchemaObject

      def initialize(value:)
        super(value: value, unit: "kWh")
      end

      def valid?
        Validator.valid?(Float, value, required: true) &&
          Validator.valid?(String, unit, const: "kWh", required: true)
      end
    end
  end
end
