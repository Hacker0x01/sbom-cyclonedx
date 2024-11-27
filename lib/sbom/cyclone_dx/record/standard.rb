# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"
require_relative "external_reference"
require_relative "property"

# Standard - A standard may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Standard
      class Standard < Base
        # Schema name: Level
        class Level < Base
          # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
          prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
          # Identifier - The identifier used in the standard to identify a specific level.
          prop :identifier, :string
          # Title - The title of the level.
          prop :title, :string
          # Description - The description of the level.
          prop :description, :string
          # Requirements - The list of requirement `bom-ref`s that comprise the level.
          prop :requirements, :array, items: [:string, pattern: Pattern::REF_LINK]
        end

        # Schema name: Requirement
        class Requirement < Base
          # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
          prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
          # Identifier - The unique identifier used in the standard to identify a specific requirement. This should match what is in the standard and should not be the requirements bom-ref.
          prop :identifier, :string
          # Title - The title of the requirement.
          prop :title, :string
          # Text - The textual content of the requirement.
          prop :text, :string
          # Descriptions - The supplemental text that provides additional guidance or context to the requirement, but is not directly part of the requirement.
          prop :descriptions, :array, items: :string
          # OWASP OpenCRE Identifier(s) - The Common Requirements Enumeration (CRE) identifier(s). CRE is a structured and standardized framework for uniting security standards and guidelines. CRE links each section of a resource to a shared topic identifier (a Common Requirement). Through this shared topic link, all resources map to each other. Use of CRE promotes clear and unambiguous communication among stakeholders.
          # Example: ["CRE:764-507"]
          prop :open_cre, :array, items: [:string, pattern: Pattern::OPEN_CRE]
          # Parent BOM Reference - The optional `bom-ref` to a parent requirement. This establishes a hierarchy of requirements. Top-level requirements must not define a parent. Only child requirements should define parents.
          prop :parent, :string, pattern: Pattern::REF_LINK
          # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
          prop :properties, :array, items: Property
          # External References - External references provide a way to document systems, sites, and information that may be relevant, but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
          prop :external_references, :array, items: ExternalReference
        end

        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Name - The name of the standard. This will often be a shortened, single name of the standard.
        prop :name, :string
        # Version - The version of the standard.
        prop :version, :string
        # Description - The description of the standard.
        prop :description, :string
        # Owner - The owner of the standard, often the entity responsible for its release.
        prop :owner, :string
        # Requirements - The list of requirements comprising the standard.
        prop :requirements, :array, items: Requirement
        # Levels - The list of levels associated with the standard. Some standards have different levels of compliance.
        prop :levels, :array, items: Level
        # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
        prop :external_references, :array, items: ExternalReference
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, :union, of: Signature::UNION_TYPE
      end
    end
  end
end
