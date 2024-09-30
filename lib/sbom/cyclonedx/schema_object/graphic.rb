# frozen_string_literal: true
# rbs_inline: enabled

# Graphic
module Sbom
  module Cyclonedx
    class Graphic < SchemaObject
      # Name - The name of the graphic.
      attr_accessor :name #: String

      # Graphic Image - The graphic (vector or raster). Base64 encoding must be specified for binary images.
      attr_accessor :image #: Attachment
    end
  end
end
