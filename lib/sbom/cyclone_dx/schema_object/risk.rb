# frozen_string_literal: true
# rbs_inline: enabled

# Risk
module SBOM
  module CycloneDX
    Risk = SchemaObject.build("Risk") do
      # Name - The name of the risk.
      prop :name, String

      # Mitigation Strategy - Strategy used to address this risk.
      prop :mitigation_strategy, String
    end
  end
end
