# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"
require_relative "component"
require_relative "organizational_contact"
require_relative "organizational_entity"
require_relative "service"
require_relative "signature"

# Annotations - A comment, note, explanation, or similar textual content which provides additional context to the object(s) being annotated.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Annotation
      class Annotation < Base
        # Schema name: Annotator
        class Annotator < Base
          # Organization - The organization that created the annotation
          prop :organization, OrganizationalEntity
          # Individual - The person that created the annotation
          prop :individual, OrganizationalContact
          # Component - The tool or component that created the annotation
          prop :component, Component
          # Service - The service that created the annotation
          prop :service, Service

          validate :organization, :individual, :component, :service, presence: :any
        end

        # BOM Reference - An optional identifier which can be used to reference the annotation elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Subjects - The object in the BOM identified by its bom-ref. This is often a component or service, but may be any object type supporting bom-refs.
        prop :subjects, :array, items: [:string, pattern: Pattern::REF_OR_CDX_URN], unique: true, required: true
        # Annotator - The organization, person, component, or service which created the textual content of the annotation.
        prop :annotator, Annotator, required: true
        # Timestamp - The date and time (timestamp) when the annotation was created.
        prop :timestamp, :date_time, required: true
        # Text - The textual content of the annotation.
        prop :text, :string, required: true
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, :union, of: [Signature::JSFSignature, Signature::SignatureChain, Signature::SignerList]
      end
    end
  end
end
