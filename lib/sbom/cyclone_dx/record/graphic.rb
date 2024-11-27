# frozen_string_literal: true

require_relative "base"
require_relative "attachment"

# Graphic
module SBOM
  module CycloneDX
    module Record
      # Schema name: Graphic
      class Graphic < Base
        # Name - The name of the graphic.
        prop :name, :string
        # Graphic Image - The graphic (vector or raster). Base64 encoding must be specified for binary images.
        prop :image, Attachment
      end
    end
  end
end
