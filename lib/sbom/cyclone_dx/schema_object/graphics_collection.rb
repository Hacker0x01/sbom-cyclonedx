# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Graphics Collection - A collection of graphics that represent various measurements.
module SBOM
  module CycloneDX
    class GraphicsCollection < Struct.new(
      "GraphicsCollection",
      # Description - A description of this collection of graphics.
      :description,
      # Collection - A collection of graphics.
      :collection,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, description) &&
          Validator.valid?(Array, collection, items: Graphic)
      end
    end
  end
end
