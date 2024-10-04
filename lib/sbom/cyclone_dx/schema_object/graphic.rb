# frozen_string_literal: true
# rbs_inline: enabled

# Graphic
module SBOM
  module CycloneDX
    Graphic = SchemaObject.build("Graphic") do
      # Name - The name of the graphic.
      prop :name, String

      # Graphic Image - The graphic (vector or raster). Base64 encoding must be specified for binary images.
      prop :image, Attachment
    end
  end
end
