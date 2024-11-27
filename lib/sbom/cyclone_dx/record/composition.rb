# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "component"
require_relative "service"
require_relative "vulnerability"

# Compositions
module SBOM
  module CycloneDX
    module Record
      # Schema name: Composition
      class Composition < Base
        # BOM Reference - An optional identifier which can be used to reference the composition elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Aggregate - Specifies an aggregate type that describe how complete a relationship is.
        prop :aggregate, :string, enum: Enum::AGGREGATE_TYPE
        # BOM references - The bom-ref identifiers of the components or services being described. Assemblies refer to nested relationships whereby a constituent part may include other constituent parts. References do not cascade to child parts. References are explicit for the specified constituent part only.
        prop :assemblies, :array, items: [:string, pattern: Pattern::REF_OR_CDX_URN], unique: true
        # BOM references - The bom-ref identifiers of the components or services being described. Dependencies refer to a relationship whereby an independent constituent part requires another independent constituent part. References do not cascade to transitive dependencies. References are explicit for the specified dependency only.
        # TODO: Serialize to a BOMLinkElement
        prop :dependencies, :array, items: [:union, of: [Component, Service]], unique: true
        # BOM references - The bom-ref identifiers of the vulnerabilities being described.
        # TODO: Serialize to a BOMLinkElement
        prop :vulnerabilities, :array, items: Vulnerability, unique: true
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, :union, of: Signature::UNION_TYPE
      end
    end
  end
end
