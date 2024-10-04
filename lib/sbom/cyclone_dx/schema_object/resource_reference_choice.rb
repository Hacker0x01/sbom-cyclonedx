# frozen_string_literal: true
# rbs_inline: enabled

# Resource reference choice - A reference to a locally defined resource (e.g., a bom-ref) or an externally accessible resource.
module SBOM
  module CycloneDX
    ResourceReferenceChoice = SchemaObject.build("ResourceReferenceChoice") do
      # BOM Reference - References an object by its bom-ref attribute
      prop :ref, String, pattern: Pattern::REF_LINK_OR_BOM_LINK_ELEMENT, required: -> { external_reference.nil? }

      # External reference - Reference to an externally accessible resource.
      prop :external_reference, ExternalReference, required: -> { ref.nil? }
    end
  end
end
