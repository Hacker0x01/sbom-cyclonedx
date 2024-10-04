# frozen_string_literal: true
# rbs_inline: enabled

# Compositions
module SBOM
  module CycloneDX
    Composition = SchemaObject.build("Composition") do
      # BOM Reference - An optional identifier which can be used to reference the composition elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_name: "bom-ref", pattern: Pattern::REF_LINK

      # Aggregate - Specifies an aggregate type that describe how complete a relationship is.
      prop :aggregate, String, enum: Enum::AGGREGATE_TYPE, required: true, default: AggregateType::NOT_SPECIFIED

      # BOM references - The bom-ref identifiers of the components or services being described. Assemblies refer to nested relationships whereby a constituent part may include other constituent parts. References do not cascade to child parts. References are explicit for the specified constituent part only.
      prop :assemblies, Set[String], all: { pattern: Pattern::REF_LINK_OR_BOM_LINK_ELEMENT }

      # BOM references - The bom-ref identifiers of the components or services being described. Dependencies refer to a relationship whereby an independent constituent part requires another independent constituent part. References do not cascade to transitive dependencies. References are explicit for the specified dependency only.
      # TODO: Serialize to a BOMLinkElement
      prop :dependencies, Set[one_of: [Component, Service]]

      # BOM references - The bom-ref identifiers of the vulnerabilities being described.
      # TODO: Serialize to a BOMLinkElement
      prop :vulnerabilities, Set[Vulnerability]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      prop :signature, Signature
    end
  end
end
