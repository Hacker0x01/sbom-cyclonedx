# frozen_string_literal: true
# rbs_inline: enabled

# Input and Output Parameters
module SBOM
  module CycloneDX
    InputOutputMLParameter = SchemaObject.build("InputOutputMLParameter") do
      # Input/Output Format - The data format for input/output to the model.
      # Examples: "string", "image", "time-series"
      prop :format, String
    end
  end
end
