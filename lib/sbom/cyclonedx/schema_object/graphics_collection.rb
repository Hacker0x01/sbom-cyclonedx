# frozen_string_literal: true
# rbs_inline: enabled

# Graphics Collection - A collection of graphics that represent various measurements.
module Sbom
  module Cyclonedx
    class GraphicsCollection < SchemaObject
      # Description - A description of this collection of graphics.
      attr_accessor :description #: String

      # Collection - A collection of graphics.
      attr_accessor :collection #: [Graphic]
    end
  end
end
