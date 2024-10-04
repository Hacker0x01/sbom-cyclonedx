# frozen_string_literal: true
# rbs_inline: enabled

# Parameter - A representation of a functional parameter.
module SBOM
  module CycloneDX
    Parameter = SchemaObject.build("Parameter") do
      # Name - The name of the parameter.
      prop :name, String

      # Value - The value of the parameter.
      prop :value, String

      # Data type - The data type of the parameter.
      prop :data_type, String
    end
  end
end
