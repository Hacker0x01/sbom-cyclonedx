# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Identity Evidence - Evidence that substantiates the identity of a component.
module SBOM
  module CycloneDX
    class ComponentIdentityEvidence < Struct.new(
      "ComponentIdentityEvidence",
      # Field - The identity field of the component which the evidence describes.
      :field,
      # Confidence - The overall confidence of the evidence from 0 - 1, where 1 is 100% confidence.
      :confidence,
      # Concluded Value - The value of the field (cpe, purl, etc) that has been concluded based on the aggregate of all methods (if available).
      :concluded_value,
      # Methods - The methods used to extract and/or analyze the evidence.
      :methods_used,
      # BOM References - The object in the BOM identified by its bom-ref. This is often a component or service but may be any object type supporting bom-refs. Tools used for analysis should already be defined in the BOM, either in the metadata/tools, components, or formulation.
      :tools,
      keyword_init: true
    )
      include SchemaObject

      json_name :methods_used, "methods"

      def initialize(field:, confidence: nil, concluded_value: nil, methods_used: nil, tools: nil)
        super
      end

      def valid?
        Validator.valid?(String, field, enum: Enum::FIELD, required: true) &&
          Validator.valid?(Float, confidence, minimum: 0, maximum: 1) &&
          Validator.valid?(String, concluded_value) &&
          Validator.valid?(Array, methods_used, items: Method) &&
          Validator.valid?(
            Array,
            tools,
            unique: true,
            items: [String, pattern: Pattern::REF_LINK_OR_BOM_LINK_ELEMENT]
          )
      end

      class Method < Struct.new(
        "Method",
        # Technique - The technique used in this method of analysis.
        :technique,
        # Confidence - The confidence of the evidence from 0 - 1, where 1 is 100% confidence. Confidence is specific to the technique used. Each technique of analysis can have independent confidence.
        :confidence,
        # Value - The value or contents of the evidence.
        :value,
        keyword_init: true
      )
        include SchemaObject

        def initialize(technique:, confidence:, value: nil)
          super
        end

        def valid?
          Validator.valid?(String, technique, enum: Enum::TECHNIQUE, required: true) &&
            Validator.valid?(Float, confidence, minimum: 0, maximum: 1, required: true) &&
            Validator.valid?(String, value)
        end
      end
    end
  end
end
