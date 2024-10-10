# frozen_string_literal: true
# rbs_inline: enabled

# Standard - A standard may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to.
module SBOM
  module CycloneDX
    Standard = SchemaObject.build("Standard") do
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

      # Name - The name of the standard. This will often be a shortened, single name of the standard.
      prop :name, String

      # Version - The version of the standard.
      prop :version, String

      # Description - The description of the standard.
      prop :description, String

      # Owner - The owner of the standard, often the entity responsible for its release.
      prop :owner, String

      # Requirements - The list of requirements comprising the standard.
      prop :requirements, [Requirement]

      # Levels - The list of levels associated with the standard. Some standards have different levels of compliance.
      prop :levels, [Level]

      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      prop :external_references, [ExternalReference]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      prop :signature, Signature

      Level = SchemaObject.build("Level") do
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

        # Identifier - The identifier used in the standard to identify a specific level.
        prop :identifier, String

        # Title - The title of the level.
        prop :title, String

        # Description - The description of the level.
        prop :description, String

        # Requirements - The list of requirement `bom-ref`s that comprise the level.
        prop :requirements, [String], all: { pattern: Pattern::REF_LINK }
      end

      Requirement = SchemaObject.build("Requirement") do
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

        # Identifier - The unique identifier used in the standard to identify a specific requirement. This should match what is in the standard and should not be the requirements bom-ref.
        prop :identifier, String

        # Title - The title of the requirement.
        prop :title, String

        # Text - The textual content of the requirement.
        prop :text, String

        # Descriptions - The supplemental text that provides additional guidance or context to the requirement, but is not directly part of the requirement.
        prop :descriptions, [String]

        # OWASP OpenCRE Identifier(s) - The Common Requirements Enumeration (CRE) identifier(s). CRE is a structured and standardized framework for uniting security standards and guidelines. CRE links each section of a resource to a shared topic identifier (a Common Requirement). Through this shared topic link, all resources map to each other. Use of CRE promotes clear and unambiguous communication among stakeholders.
        # Example: ["CRE:764-507"]
        prop :open_cre, [String], all: { pattern: Pattern::OPEN_CRE }

        # Parent BOM Reference - The optional `bom-ref` to a parent requirement. This establishes a hierarchy of requirements. Top-level requirements must not define a parent. Only child requirements should define parents.
        prop :parent, String, pattern: Pattern::REF_LINK

        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, [Property]

        # External References - External references provide a way to document systems, sites, and information that may be relevant, but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
        prop :external_references, [ExternalReference]
      end
    end
  end
end
