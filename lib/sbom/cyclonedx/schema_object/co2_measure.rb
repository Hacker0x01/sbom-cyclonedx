# frozen_string_literal: true
# rbs_inline: enabled

# CO2 Measure - A measure of carbon dioxide (CO2).
module SBOM
  module Cyclonedx
    class CO2Measure < SchemaObject
      # Value - Quantity of carbon dioxide (CO2).
      attr_accessor :value #: Float

      validate :value, required: true

      # Unit - Unit of carbon dioxide (CO2).
      def unit
        # Tonnes (t) of carbon dioxide (CO2) equivalent (eq).
        "tCO2eq"
      end

      # This is statically-defined, but seems like it might not always be, and the spec marks it as requried
      validate :unit, required: true
    end
  end
end
