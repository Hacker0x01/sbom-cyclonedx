# frozen_string_literal: true
# rbs_inline: enabled

# Input and Output Parameters
module Sbom
  module Cyclonedx
    class InputOutputMlParameter < SchemaObject
      # Input/Output Format - The data format for input/output to the model.
      # Examples: "string", "image", "time-series"
      attr_accessor :format #: String
    end
  end
end
