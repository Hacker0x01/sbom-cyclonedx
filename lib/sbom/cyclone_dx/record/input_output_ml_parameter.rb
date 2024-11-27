# frozen_string_literal: true

require_relative "base"

# Input and Output Parameters
module SBOM
  module CycloneDX
    module Record
      # Schema name: InputOutputMLParameter
      class InputOutputMLParameter < Base
        # Input/Output Format - The data format for input/output to the model.
        # Examples: "string", "image", "time-series"
        prop :format, :string
      end
    end
  end
end
