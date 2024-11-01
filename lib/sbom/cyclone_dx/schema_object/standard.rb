# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"
require_relative "external_reference"
require_relative "property"

# Standard - A standard may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to.
module SBOM
  module CycloneDX
    class Standard < Struct.new(
      "Standard",
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
      :bom_ref,
      # Name - The name of the standard. This will often be a shortened, single name of the standard.
      :name,
      # Version - The version of the standard.
      :version,
      # Description - The description of the standard.
      :description,
      # Owner - The owner of the standard, often the entity responsible for its release.
      :owner,
      # Requirements - The list of requirements comprising the standard.
      :requirements,
      # Levels - The list of levels associated with the standard. Some standards have different levels of compliance.
      :levels,
      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      :external_references,
      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      :signature,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def valid? # rubocop:disable Metrics/PerceivedComplexity
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(String, name) &&
          Validator.valid?(String, version) &&
          Validator.valid?(String, description) &&
          Validator.valid?(String, owner) &&
          Validator.valid?(Array, requirements, items: Requirement) &&
          Validator.valid?(Array, levels, items: Level) &&
          Validator.valid?(Array, external_references, items: ExternalReference) &&
          Signature.valid?(signature)
      end

      class Level < Struct.new(
        "Level",
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        :bom_ref,
        # Identifier - The identifier used in the standard to identify a specific level.
        :identifier,
        # Title - The title of the level.
        :title,
        # Description - The description of the level.
        :description,
        # Requirements - The list of requirement `bom-ref`s that comprise the level.
        :requirements,
        keyword_init: true
      )
        include SchemaObject

        json_name :bom_ref, "bom-ref"

        def valid?
          Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
            Validator.valid?(String, identifier) &&
            Validator.valid?(String, title) &&
            Validator.valid?(String, description) &&
            Validator.valid?(Array, requirements, items: [String, pattern: Pattern::REF_LINK])
        end
      end

      class Requirement < Struct.new(
        "Requirement",
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        :bom_ref,
        # Identifier - The unique identifier used in the standard to identify a specific requirement. This should match what is in the standard and should not be the requirements bom-ref.
        :identifier,
        # Title - The title of the requirement.
        :title,
        # Text - The textual content of the requirement.
        :text,
        # Descriptions - The supplemental text that provides additional guidance or context to the requirement, but is not directly part of the requirement.
        :descriptions,
        # OWASP OpenCRE Identifier(s) - The Common Requirements Enumeration (CRE) identifier(s). CRE is a structured and standardized framework for uniting security standards and guidelines. CRE links each section of a resource to a shared topic identifier (a Common Requirement). Through this shared topic link, all resources map to each other. Use of CRE promotes clear and unambiguous communication among stakeholders.
        # Example: ["CRE:764-507"]
        :open_cre,
        # Parent BOM Reference - The optional `bom-ref` to a parent requirement. This establishes a hierarchy of requirements. Top-level requirements must not define a parent. Only child requirements should define parents.
        :parent,
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        :properties,
        # External References - External references provide a way to document systems, sites, and information that may be relevant, but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
        :external_references,
        keyword_init: true
      )
        include SchemaObject

        json_name :bom_ref, "bom-ref"

        def valid? # rubocop:disable Metrics/PerceivedComplexity
          Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
            Validator.valid?(String, identifier) &&
            Validator.valid?(String, title) &&
            Validator.valid?(String, text) &&
            Validator.valid?(Array, descriptions, items: String) &&
            Validator.valid?(Array, open_cre, items: [String, pattern: Pattern::OPEN_CRE]) &&
            Validator.valid?(String, parent, pattern: Pattern::REF_LINK) &&
            Validator.valid?(Array, properties, items: Property) &&
            Validator.valid?(Array, external_references, items: ExternalReference)
        end
      end
    end
  end
end
