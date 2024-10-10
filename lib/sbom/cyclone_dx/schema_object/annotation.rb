# frozen_string_literal: true
# rbs_inline: enabled

# Annotations - A comment, note, explanation, or similar textual content which provides additional context to the object(s) being annotated.
module SBOM
  module CycloneDX
    Annotation = SchemaObject.build("Annotation") do
      # BOM Reference - An optional identifier which can be used to reference the annotation elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

      # Subjects - The object in the BOM identified by its bom-ref. This is often a component or service, but may be any object type supporting bom-refs.
      prop :subjects,
           Set[String],
           required: true,
           all: { pattern: Pattern::REF_LINK_OR_BOM_LINK_ELEMENT }

      # Annotator - The organization, person, component, or service which created the textual content of the annotation.
      prop :annotator, Annotator, required: true

      # Timestamp - The date and time (timestamp) when the annotation was created.
      prop :timestamp, DateTime, required: true

      # Text - The textual content of the annotation.
      prop :text, String, required: true

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      prop :signature, Signature

      Annotator = SchemaObject.build("Annotator") do
        # The organization that created the annotation
        prop :organization, OrganizationalEntity, required: -> { individual.nil? && component.nil? && service.nil? }

        # The person that created the annotation
        prop :individual, OrganizationalContact, required: -> { organization.nil? && component.nil? && service.nil? }

        # The tool or component that created the annotation
        prop :component, Component, required: -> { organization.nil? && individual.nil? && service.nil? }

        # The service that created the annotation
        prop :service, Service, required: -> { organization.nil? && individual.nil? && component.nil? }
      end
    end
  end
end
