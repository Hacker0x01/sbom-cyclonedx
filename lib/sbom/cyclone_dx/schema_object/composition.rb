# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Compositions
module SBOM
  module CycloneDX
    class Composition < Struct.new(
      "Composition",
      # BOM Reference - An optional identifier which can be used to reference the composition elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Aggregate - Specifies an aggregate type that describe how complete a relationship is.
      :aggregate,
      # BOM references - The bom-ref identifiers of the components or services being described. Assemblies refer to nested relationships whereby a constituent part may include other constituent parts. References do not cascade to child parts. References are explicit for the specified constituent part only.
      :assemblies,
      # BOM references - The bom-ref identifiers of the components or services being described. Dependencies refer to a relationship whereby an independent constituent part requires another independent constituent part. References do not cascade to transitive dependencies. References are explicit for the specified dependency only.
      # TODO: Serialize to a BOMLinkElement
      :dependencies,
      # BOM references - The bom-ref identifiers of the vulnerabilities being described.
      # TODO: Serialize to a BOMLinkElement
      :vulnerabilities,
      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      :signature,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def initialize(
        aggregate: "not_specified",
        bom_ref: nil,
        assemblies: nil,
        dependencies: nil,
        vulnerabilities: nil,
        signature: nil
      )
        super
      end

      def valid? # rubocop:disable Metrics/MethodLength
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(String, aggregate, enum: Enum::AGGREGATE_TYPE, required: true) &&
          Validator.valid?(
            Array,
            assemblies,
            unique: true,
            items: [String, pattern: Pattern::REF_LINK_OR_BOM_LINK_ELEMENT]
          ) &&
          Validator.valid?(
            Array,
            dependencies,
            unique: true,
            items: [Union, klasses: [Component, Service]]
          ) &&
          Validator.valid?(
            Array,
            vulnerabilities,
            unique: true,
            items: Vulnerability
          ) &&
          Signature.valid?(signature)
      end
    end
  end
end
