# frozen_string_literal: true
# rbs_inline: enabled

# Fairness Assessment - Information about the benefits and harms of the model to an identified at risk group.
module SBOM
  module CycloneDX
    FairnessAssessment = SchemaObject.build("FairnessAssessment") do
      # Group at Risk - The groups or individuals at risk of being systematically disadvantaged by the model.
      prop :group_at_risk, String

      # Benefits - Expected benefits to the identified groups.
      prop :benefits, String

      # Harms - Expected harms to the identified groups.
      prop :harms, String

      # Mitigation Strategy - With respect to the benefits and harms outlined, please describe any mitigation strategy implemented.
      prop :mitigation_strategy, String
    end
  end
end
