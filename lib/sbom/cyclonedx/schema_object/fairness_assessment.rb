# frozen_string_literal: true
# rbs_inline: enabled

# Fairness Assessment - Information about the benefits and harms of the model to an identified at risk group.
module SBOM
  module Cyclonedx
    class FairnessAssessment < SchemaObject
      # Group at Risk - The groups or individuals at risk of being systematically disadvantaged by the model.
      attr_accessor :group_at_risk #: String

      # Benefits - Expected benefits to the identified groups.
      attr_accessor :benefits #: String

      # Harms - Expected harms to the identified groups.
      attr_accessor :harms #: String

      # Mitigation Strategy - With respect to the benefits and harms outlined, please describe any mitigation strategy implemented.
      attr_accessor :mitigation_strategy #: String
    end
  end
end
