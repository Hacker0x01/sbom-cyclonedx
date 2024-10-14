# frozen_string_literal: true

require_relative "../schema_object"

# Risk
module SBOM
  module CycloneDX
    class Risk < Struct.new(
      "Risk",
      # Name - The name of the risk.
      :name,
      # Mitigation Strategy - Strategy used to address this risk.
      :mitigation_strategy,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, name) &&
          Validator.valid?(String, mitigation_strategy)
      end
    end
  end
end
