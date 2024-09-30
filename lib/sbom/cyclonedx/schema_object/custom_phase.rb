# frozen_string_literal: true
# rbs_inline: enabled

# Custom Phase
module Sbom
  module Cyclonedx
    class CustomPhase < SchemaObject
      # Name - The name of the lifecycle phase
      attr_accessor :name #: String

      # Description - The description of the lifecycle phase
      attr_accessor :description #: String
    end
  end
end
