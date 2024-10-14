# frozen_string_literal: true

require_relative "../schema_object"

# Fairness Assessment - Information about the benefits and harms of the model to an identified at risk group.
module SBOM
  module CycloneDX
    class FairnessAssessment < Struct.new(
      "FairnessAssessment",
      # Group at Risk - The groups or individuals at risk of being systematically disadvantaged by the model.
      :group_at_risk,
      # Benefits - Expected benefits to the identified groups.
      :benefits,
      # Harms - Expected harms to the identified groups.
      :harms,
      # Mitigation Strategy - With respect to the benefits and harms outlined, please describe any mitigation strategy implemented.
      :mitigation_strategy,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, group_at_risk) &&
          Validator.valid?(String, benefits) &&
          Validator.valid?(String, harms) &&
          Validator.valid?(String, mitigation_strategy)
      end
    end
  end
end
