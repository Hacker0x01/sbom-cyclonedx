# frozen_string_literal: true

require_relative "base"

# Energy Measure - A measure of energy.
module SBOM
  module CycloneDX
    module Record
      # Schema name: EnergyMeasure
      class EnergyMeasure < Base
        # Value - Quantity of energy.
        prop :value, :float, required: true
        # Unit - Unit of energy, currently specified as a const "kWh".
        const :unit, :string, "kWh"
      end
    end
  end
end
