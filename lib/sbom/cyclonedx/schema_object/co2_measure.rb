# frozen_string_literal: true
# rbs_inline: enabled

# CO2 Measure - A measure of carbon dioxide (CO2).
module Sbom
  module Cyclonedx
    class Co2Measure < SchemaObject
      # Value - Quantity of carbon dioxide (CO2).
      attr_accessor :value #: Float

      # Unit - Unit of carbon dioxide (CO2).
      def unit
        # Tonnes (t) of carbon dioxide (CO2) equivalent (eq).
        "tCO2eq"
      end
    end
  end
end
