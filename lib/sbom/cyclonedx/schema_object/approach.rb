# frozen_string_literal: true
# rbs_inline: enabled

# Approach - The overall approach to learning used by the model for problem solving.
module SBOM
  module Cyclonedx
    class Approach < SchemaObject
      # Learning Type - Learning types describing the learning problem or hybrid learning problem.
      attr_accessor :type #: LearningType
    end
  end
end
