# frozen_string_literal: true
# rbs_inline: enabled

# Rating - Defines the severity or risk ratings of a vulnerability.
module Sbom
  module Cyclonedx
    class Rating < SchemaObject
      # The source that calculated the severity or risk rating of the vulnerability.
      attr_accessor :source #: VulnerabilitySource

      # Score - The numerical score of the rating.
      attr_accessor :score #: Float

      # Textual representation of the severity that corresponds to the numerical score of the rating.
      attr_accessor :severity #: Severity

      attr_accessor :method #: ScoreMethod

      # Vector - Textual representation of the metric values used to score the vulnerability
      attr_accessor :vector #: String

      # Justification - An optional reason for rating the vulnerability as it was
      attr_accessor :justification #: String
    end
  end
end
