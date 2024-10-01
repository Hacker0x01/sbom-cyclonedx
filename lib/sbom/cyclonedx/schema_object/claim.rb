# frozen_string_literal: true
# rbs_inline: enabled

module SBOM
  module Cyclonedx
    class Claim < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
      attr_accessor :bom_ref #: RefLink

      # Target - The `bom-ref` to a target representing a specific system, application, API, module, team, person, process, business unit, company, etc...  that this claim is being applied to.
      attr_accessor :target #: RefLink

      # Predicate - The specific statement or assertion about the target.
      attr_accessor :predicate #: String

      # Mitigation Strategies - The list of  `bom-ref` to the evidence provided describing the mitigation strategies. Each mitigation strategy should include an explanation of how any weaknesses in the evidence will be mitigated.
      attr_accessor :mitigation_strategies #: [RefLink]

      # Reasoning - The written explanation of why the evidence provided substantiates the claim.
      attr_accessor :reasoning #: String

      # Evidence - The list of `bom-ref` to evidence that supports this claim.
      attr_accessor :evidence #: [RefLink]

      # Counter Evidence - The list of `bom-ref` to counterEvidence that supports this claim.
      attr_accessor :counter_evidence #: [RefLink]

      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      attr_accessor :external_references #: [ExternalReference]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature
    end
  end
end
