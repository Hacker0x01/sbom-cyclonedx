# frozen_string_literal: true

require_relative "../schema_object"

# Input and Output Parameters
module SBOM
  module CycloneDX
    class InputOutputMLParameter < Struct.new(
      "InputOutputMLParameter",
      # Input/Output Format - The data format for input/output to the model.
      # Examples: "string", "image", "time-series"
      :format,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, format)
      end
    end
  end
end
