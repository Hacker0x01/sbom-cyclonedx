# frozen_string_literal: true
# rbs_inline: enabled

# Standard - A standard may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to.
module SBOM
  module Cyclonedx
    class Standard < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
      attr_accessor :bom_ref #: RefLink

      # Name - The name of the standard. This will often be a shortened, single name of the standard.
      attr_accessor :name #: String

      # Version - The version of the standard.
      attr_accessor :version #: String

      # Description - The description of the standard.
      attr_accessor :description #: String

      # Owner - The owner of the standard, often the entity responsible for its release.
      attr_accessor :owner #: String

      # Requirements - The list of requirements comprising the standard.
      attr_accessor :requirements #: [Requirement]

      # Levels - The list of levels associated with the standard. Some standards have different levels of compliance.
      attr_accessor :levels #: [Level]

      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      attr_accessor :external_references #: [ExternalReference]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature
    end
  end
end
