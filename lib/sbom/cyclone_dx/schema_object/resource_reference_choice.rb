# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"

# Resource reference choice - A reference to a locally defined resource (e.g., a bom-ref) or an externally accessible resource.
module SBOM
  module CycloneDX
    class ResourceReferenceChoice < Struct.new(
      "ResourceReferenceChoice",
      # BOM Reference - References an object by its bom-ref attribute
      :ref,
      # External reference - Reference to an externally accessible resource.
      :external_reference,
      keyword_init: true
    )
      include SchemaObject

      def initialize(ref: nil, external_reference: nil)
        raise ArgumentError, "must provide either ref or external_reference" if ref.nil? && external_reference.nil?

        super
      end

      def valid?
        Validator.valid?(
          String, ref,
          pattern: Pattern::REF_OR_CDX_URN,
          required: external_reference.nil?
        ) &&
          Validator.valid?(ExternalReference, external_reference, required: ref.nil?)
      end
    end
  end
end
