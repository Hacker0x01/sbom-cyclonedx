# frozen_string_literal: true
# rbs_inline: enabled

# Rating - Defines the severity or risk ratings of a vulnerability.
module SBOM
  module CycloneDX
    Rating = SchemaObject.build("Rating") do
      # The source that calculated the severity or risk rating of the vulnerability.
      prop :source, VulnerabilitySource

      # Score - The numerical score of the rating.
      prop :score, Float

      # Textual representation of the severity that corresponds to the numerical score of the rating.
      prop :severity, String, enum: Enum::SEVERITY

      prop :method, String, enum: Enum::SCORE_METHOD

      # Vector - Textual representation of the metric values used to score the vulnerability
      prop :vector, String

      # Justification - An optional reason for rating the vulnerability as it was
      prop :justification, String
    end
  end
end
