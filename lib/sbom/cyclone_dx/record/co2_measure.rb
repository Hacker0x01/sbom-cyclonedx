# frozen_string_literal: true

require_relative "base"

# CO2 Measure - A measure of carbon dioxide (CO2).
module SBOM
  module CycloneDX
    module Record
      # Schema name: CO2Measure
      class CO2Measure < Base
        # Value - Quantity of carbon dioxide (CO2).
        prop :value, :float, required: true
        # Unit - Unit of carbon dioxide (CO2), currently specified as a const "tCO2eq".
        const :unit, :string, "tCO2eq"
      end
    end
  end
end
