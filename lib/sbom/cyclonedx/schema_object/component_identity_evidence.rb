# frozen_string_literal: true
# rbs_inline: enabled

# Identity Evidence - Evidence that substantiates the identity of a component.
module SBOM
  module Cyclonedx
    class ComponentIdentityEvidence < SchemaObject
      # Field - The identity field of the component which the evidence describes.
      attr_accessor :field #: Field

      validate :field, required: true

      # Confidence - The overall confidence of the evidence from 0 - 1, where 1 is 100% confidence.
      attr_accessor :confidence #: Float

      validate :confidence, minimum: 0, maximum: 1

      # Concluded Value - The value of the field (cpe, purl, etc) that has been concluded based on the aggregate of all methods (if available).
      attr_accessor :concluded_value #: String

      # Methods - The methods used to extract and/or analyze the evidence.
      attr_accessor :methods #: [Method]

      # BOM References - The object in the BOM identified by its bom-ref. This is often a component or service but may be any object type supporting bom-refs. Tools used for analysis should already be defined in the BOM, either in the metadata/tools, components, or formulation.
      attr_accessor :tools #: Set[RefLink | BOMLinkElement]
    end
  end
end
