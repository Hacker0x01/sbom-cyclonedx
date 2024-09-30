# frozen_string_literal: true
# rbs_inline: enabled

# Annotations - A comment, note, explanation, or similar textual content which provides additional context to the object(s) being annotated.
module Sbom
  module Cyclonedx
    class Annotation < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the annotation elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Subjects - The object in the BOM identified by its bom-ref. This is often a component or service, but may be any object type supporting bom-refs.
      attr_accessor :subjects #: Set[RefLink | BOMLinkElement]

      # Annotator - The organization, person, component, or service which created the textual content of the annotation.
      attr_accessor :annotator #: Annotator

      # Timestamp - The date and time (timestamp) when the annotation was created.
      attr_accessor :timestamp #: DateTime

      # Text - The textual content of the annotation.
      attr_accessor :text #: String

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature
    end
  end
end
