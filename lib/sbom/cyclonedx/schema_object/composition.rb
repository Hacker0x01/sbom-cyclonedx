# frozen_string_literal: true
# rbs_inline: enabled

# Compositions
module Sbom
  module Cyclonedx
    class Composition < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the composition elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Aggregate - Specifies an aggregate type that describe how complete a relationship is.
      attr_accessor :aggregate #: AggregateType

      # BOM references - The bom-ref identifiers of the components or services being described. Assemblies refer to nested relationships whereby a constituent part may include other constituent parts. References do not cascade to child parts. References are explicit for the specified constituent part only.
      attr_accessor :assemblies #: Set[RefLink | BOMLinkElement]

      # BOM references - The bom-ref identifiers of the components or services being described. Dependencies refer to a relationship whereby an independent constituent part requires another independent constituent part. References do not cascade to transitive dependencies. References are explicit for the specified dependency only.
      # TODO: Serialize to a BOMLinkElement
      attr_accessor :dependencies #: Set[Component | Service]

      # BOM references - The bom-ref identifiers of the vulnerabilities being described.
      # TODO: Serialize to a BOMLinkElement
      attr_accessor :vulnerabilities #: Set[Vulnerability]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature
    end
  end
end
