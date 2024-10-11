# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Parameter - A representation of a functional parameter.
module SBOM
  module CycloneDX
    class Parameter < Struct.new(
      "Parameter",
      # Name - The name of the parameter.
      :name,
      # Value - The value of the parameter.
      :value,
      # Data type - The data type of the parameter.
      :data_type,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, name) &&
          Validator.valid?(String, value) &&
          Validator.valid?(String, data_type)
      end
    end
  end
end
