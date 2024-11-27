# frozen_string_literal: true

require_relative "base"

# Fairness Assessment - Information about the benefits and harms of the model to an identified at risk group.
module SBOM
  module CycloneDX
    module Record
      # Schema name: FairnessAssessment
      class FairnessAssessment < Base
        # Group at Risk - The groups or individuals at risk of being systematically disadvantaged by the model.
        prop :group_at_risk, :string
        # Benefits - Expected benefits to the identified groups.
        prop :benefits, :string
        # Harms - Expected harms to the identified groups.
        prop :harms, :string
        # Mitigation Strategy - With respect to the benefits and harms outlined, please describe any mitigation strategy implemented.
        prop :mitigation_strategy, :string
      end
    end
  end
end
