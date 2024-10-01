# frozen_string_literal: true
# rbs_inline: enabled

# Level
module SBOM
  module Cyclonedx
    class Level < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
      attr_accessor :bom_ref #: RefLink

      # Identifier - The identifier used in the standard to identify a specific level.
      attr_accessor :identifier #: String

      # Title - The title of the level.
      attr_accessor :title #: String

      # Description - The description of the level.
      attr_accessor :description #: String

      # Requirements - The list of requirement `bom-ref`s that comprise the level.
      attr_accessor :requirements #: [RefLink]
    end
  end
end
