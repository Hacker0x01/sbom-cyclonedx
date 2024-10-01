# frozen_string_literal: true
# rbs_inline: enabled

# Resource reference choice - A reference to a locally defined resource (e.g., a bom-ref) or an externally accessible resource.
module SBOM
  module Cyclonedx
    class ResourceReferenceChoice < SchemaObject
      # BOM Reference - References an object by its bom-ref attribute
      attr_accessor :ref #: RefLink | BOMLinkElement

      # External reference - Reference to an externally accessible resource.
      attr_accessor :external_reference #: ExternalReference
    end
  end
end
