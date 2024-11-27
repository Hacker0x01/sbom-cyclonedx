# frozen_string_literal: true

require_relative "../enum"
require_relative "base"
require_relative "vulnerability_source"

# Rating - Defines the severity or risk ratings of a vulnerability.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Rating
      class Rating < Base
        # The source that calculated the severity or risk rating of the vulnerability.
        prop :source, VulnerabilitySource
        # Score - The numerical score of the rating.
        prop :score, :float
        # Textual representation of the severity that corresponds to the numerical score of the rating.
        prop :severity, :string, enum: Enum::SEVERITY
        prop :score_method, :string, enum: Enum::SCORE_METHOD, json_name: "method"
        # Vector - Textual representation of the metric values used to score the vulnerability
        prop :vector, :string
        # Justification - An optional reason for rating the vulnerability as it was
        prop :justification, :string
      end
    end
  end
end
