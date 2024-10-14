# frozen_string_literal: true

require_relative "../schema_object"

# Graphic
module SBOM
  module CycloneDX
    class Graphic < Struct.new(
      "Graphic",
      # Name - The name of the graphic.
      :name,
      # Graphic Image - The graphic (vector or raster). Base64 encoding must be specified for binary images.
      :image,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, name) &&
          Validator.valid?(Attachment, image)
      end
    end
  end
end
