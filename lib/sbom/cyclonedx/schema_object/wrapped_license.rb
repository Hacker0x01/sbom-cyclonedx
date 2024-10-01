# frozen_string_literal: true
# rbs_inline: enabled

module SBOM
  module Cyclonedx
    class WrappedLicense < SchemaObject
      # License - The license information for the BOM document. This may be different from the license(s) of the component(s) that the BOM describes.
      attr_accessor :license #: License

      validate :license, required: true
    end
  end
end
