# frozen_string_literal: true

require_relative "../enum"
require_relative "../schema_object"

# Rating - Defines the severity or risk ratings of a vulnerability.
module SBOM
  module CycloneDX
    class Rating < Struct.new(
      "Rating",
      # The source that calculated the severity or risk rating of the vulnerability.
      :source,
      # Score - The numerical score of the rating.
      :score,
      # Textual representation of the severity that corresponds to the numerical score of the rating.
      :severity,
      :score_method,
      # Vector - Textual representation of the metric values used to score the vulnerability
      :vector,
      # Justification - An optional reason for rating the vulnerability as it was
      :justification,
      keyword_init: true
    )
      include SchemaObject

      json_name :score_method, "method"

      def valid?
        Validator.valid?(VulnerabilitySource, source) &&
          Validator.valid?(Float, score) &&
          Validator.valid?(String, severity, enum: Enum::SEVERITY) &&
          Validator.valid?(String, score_method, enum: Enum::SCORE_METHOD) &&
          Validator.valid?(String, vector) &&
          Validator.valid?(String, justification)
      end
    end
  end
end
