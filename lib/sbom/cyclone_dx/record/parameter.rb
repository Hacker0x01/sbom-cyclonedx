# frozen_string_literal: true

require_relative "base"

# Parameter - A representation of a functional parameter.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Parameter
      class Parameter < Base
        # Name - The name of the parameter.
        prop :name, :string
        # Value - The value of the parameter.
        prop :value, :string
        # Data type - The data type of the parameter.
        prop :data_type, :string
      end
    end
  end
end
