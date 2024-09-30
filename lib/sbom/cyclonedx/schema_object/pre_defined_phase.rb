# frozen_string_literal: true
# rbs_inline: enabled

# Pre-Defined Phase
module Sbom
  module Cyclonedx
    class PreDefinedPhase < SchemaObject
      # Phase - A pre-defined phase in the product lifecycle.
      attr_accessor :phase #: Phase
    end
  end
end
