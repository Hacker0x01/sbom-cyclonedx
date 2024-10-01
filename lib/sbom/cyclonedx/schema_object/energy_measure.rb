# frozen_string_literal: true
# rbs_inline: enabled

# Energy Measure - A measure of energy.
module SBOM
  module Cyclonedx
    class EnergyMeasure < SchemaObject
      # Value - Quantity of energy.
      attr_accessor :value #: Float

      validate :value, required: true

      # Unit - Unit of energy.
      def unit
        # Kilowatt-hour (kWh) is the energy delivered by one kilowatt (kW) of power for one hour (h).
        "kWh"
      end

      # This is statically-defined, but seems like it might not always be, and the spec marks it as requried
      validate :unit, required: true
    end
  end
end
