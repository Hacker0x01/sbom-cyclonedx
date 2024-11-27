# frozen_string_literal: true

require_relative "base"
require_relative "graphic"

# Graphics Collection - A collection of graphics that represent various measurements.
module SBOM
  module CycloneDX
    module Record
      # Schema name: GraphicsCollection
      class GraphicsCollection < Base
        # Description - A description of this collection of graphics.
        prop :description, :string
        # Collection - A collection of graphics.
        prop :collection, :array, items: Graphic
      end
    end
  end
end
