# frozen_string_literal: true
# rbs_inline: enabled

# Parameter - A representation of a functional parameter.
module SBOM
  module Cyclonedx
    class Parameter < SchemaObject
      # Name - The name of the parameter.
      attr_accessor :name #: String

      # Value - The value of the parameter.
      attr_accessor :value #: String

      # Data type - The data type of the parameter.
      attr_accessor :data_type #: String
    end
  end
end
