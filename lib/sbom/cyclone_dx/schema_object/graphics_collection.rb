# frozen_string_literal: true
# rbs_inline: enabled

# Graphics Collection - A collection of graphics that represent various measurements.
module SBOM
  module CycloneDX
    GraphicsCollection = SchemaObject.build("GraphicsCollection") do
      # Description - A description of this collection of graphics.
      prop :description, String

      # Collection - A collection of graphics.
      prop :collection, [Graphic]
    end
  end
end
