# frozen_string_literal: true

require_relative "../schema_object"

# CO2 Measure - A measure of carbon dioxide (CO2).
module SBOM
  module CycloneDX
    class CO2Measure < Struct.new(
      "CO2Measure",
      # Value - Quantity of carbon dioxide (CO2).
      :value,
      # Unit - Unit of carbon dioxide (CO2), currently specified as a const "tCO2eq".
      :unit,
      keyword_init: true
    )
      include SchemaObject

      def initialize(value:)
        super(value: value, unit: "tCO2eq")
      end

      def valid?
        Validator.valid?(Float, value, required: true) &&
          Validator.valid?(String, unit, const: "tCO2eq", required: true)
      end
    end
  end
end
