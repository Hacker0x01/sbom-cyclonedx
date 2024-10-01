# frozen_string_literal: true
# rbs_inline: enabled

# Method
module SBOM
  module Cyclonedx
    class Method < SchemaObject
      # Technique - The technique used in this method of analysis.
      attr_accessor :technique #: Technique

      validate :technique, required: true

      # Confidence - The confidence of the evidence from 0 - 1, where 1 is 100% confidence. Confidence is specific to the technique used. Each technique of analysis can have independent confidence.
      attr_accessor :confidence #: Float

      validate :confidence, minimun: 0, maximum: 1, required: true

      # Value - The value or contents of the evidence.
      attr_accessor :value #: String
    end
  end
end
