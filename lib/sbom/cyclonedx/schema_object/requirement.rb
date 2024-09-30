# frozen_string_literal: true
# rbs_inline: enabled

# Requirement
module Sbom
  module Cyclonedx
    class Requirement < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
      attr_accessor :bom_ref #: RefLink

      # Identifier - The unique identifier used in the standard to identify a specific requirement. This should match what is in the standard and should not be the requirements bom-ref.
      attr_accessor :identifier #: String

      # Title - The title of the requirement.
      attr_accessor :title #: String

      # Text - The textual content of the requirement.
      attr_accessor :text #: String

      # Descriptions - The supplemental text that provides additional guidance or context to the requirement, but is not directly part of the requirement.
      attr_accessor :descriptions #: [String]

      # OWASP OpenCRE Identifier(s) - The Common Requirements Enumeration (CRE) identifier(s). CRE is a structured and standardized framework for uniting security standards and guidelines. CRE links each section of a resource to a shared topic identifier (a Common Requirement). Through this shared topic link, all resources map to each other. Use of CRE promotes clear and unambiguous communication among stakeholders.
      attr_accessor :open_cre #: [OpenCRE]

      # Parent BOM Reference - The optional `bom-ref` to a parent requirement. This establishes a hierarchy of requirements. Top-level requirements must not define a parent. Only child requirements should define parents.
      attr_accessor :parent #: RefLink

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]

      # External References - External references provide a way to document systems, sites, and information that may be relevant, but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      attr_accessor :external_references #: [ExternalReference]
    end
  end
end
