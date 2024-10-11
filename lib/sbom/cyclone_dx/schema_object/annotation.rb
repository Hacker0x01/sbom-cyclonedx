# frozen_string_literal: true

require_relative "signature"
require_relative "../pattern"
require_relative "../schema_object"

# Annotations - A comment, note, explanation, or similar textual content which provides additional context to the object(s) being annotated.
module SBOM
  module CycloneDX
    class Annotation < Struct.new(
      "Annotation",
      # BOM Reference - An optional identifier which can be used to reference the annotation elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Subjects - The object in the BOM identified by its bom-ref. This is often a component or service, but may be any object type supporting bom-refs.
      :subjects,
      # Annotator - The organization, person, component, or service which created the textual content of the annotation.
      :annotator,
      # Timestamp - The date and time (timestamp) when the annotation was created.
      :timestamp,
      # Text - The textual content of the annotation.
      :text,
      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      :signature,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def initialize(subjects:, annotator:, timestamp:, text:, signature: nil, bom_ref: nil) # rubocop:disable Metrics/ParameterLists
        super
      end

      def valid?
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(
            Array,
            subjects,
            unique: true,
            items: [String, pattern: Pattern::REF_LINK_OR_BOM_LINK_ELEMENT]
          ) &&
          Validator.valid?(Annotator, annotator, required: true) &&
          Validator.valid?(DateTime, timestamp, required: true) &&
          Validator.valid?(String, text, required: true) &&
          Signature.valid?(signature)
      end

      class Annotator < Struct.new(
        "Annotator",
        # Organization - The organization that created the annotation
        :organization,
        # Individual - The person that created the annotation
        :individual,
        # Component - The tool or component that created the annotation
        :component,
        # Service - The service that created the annotation
        :service,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          return false if [organization, individual, component, service].all?(&:nil?)

          Validator.valid?(OrganizationalEntity, organization) &&
            Validator.valid?(OrganizationalContact, individual) &&
            Validator.valid?(Component, component) &&
            Validator.valid?(Service, service)
        end
      end
    end
  end
end
