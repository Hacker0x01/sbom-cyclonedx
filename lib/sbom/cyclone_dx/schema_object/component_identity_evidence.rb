# frozen_string_literal: true
# rbs_inline: enabled

# Identity Evidence - Evidence that substantiates the identity of a component.
module SBOM
  module CycloneDX
    ComponentIdentityEvidence = SchemaObject.build("ComponentIdentityEvidence") do
      # Field - The identity field of the component which the evidence describes.
      prop :field, String, enum: Enum::FIELD, required: true

      # Confidence - The overall confidence of the evidence from 0 - 1, where 1 is 100% confidence.
      prop :confidence, Float, minimum: 0, maximum: 1

      # Concluded Value - The value of the field (cpe, purl, etc) that has been concluded based on the aggregate of all methods (if available).
      prop :concluded_value, String

      # Methods - The methods used to extract and/or analyze the evidence.
      prop :methods, [Method]

      # BOM References - The object in the BOM identified by its bom-ref. This is often a component or service but may be any object type supporting bom-refs. Tools used for analysis should already be defined in the BOM, either in the metadata/tools, components, or formulation.
      prop :tools, Set[String], all: { pattern: Pattern::REF_LINK_OR_BOM_LINK_ELEMENT }

      Method = SchemaObject.build("Method") do
        # Technique - The technique used in this method of analysis.
        prop :technique, String, enum: Enum::TECHNIQUE, required: true

        # Confidence - The confidence of the evidence from 0 - 1, where 1 is 100% confidence. Confidence is specific to the technique used. Each technique of analysis can have independent confidence.
        prop :confidence, Float, minimun: 0, maximum: 1, required: true

        # Value - The value or contents of the evidence.
        prop :value, String
      end
    end
  end
end
