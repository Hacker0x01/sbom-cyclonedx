# frozen_string_literal: true
# rbs_inline: enabled

# Occurrence
module SBOM
  module Cyclonedx
    class Occurrence < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the occurrence elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Location - The location or path to where the component was found.
      attr_accessor :location #: String

      validate :location, required: true

      # Line Number - The line number where the component was found.
      attr_accessor :line #: Integer

      validate :line, minimum: 0

      # Offset - The offset where the component was found.
      attr_accessor :offset #: Integer

      validate :offset, minimum: 0

      # Symbol - The symbol name that was found associated with the component.
      attr_accessor :symbol #: String

      # Additional Context - Any additional context of the detected component (e.g. a code snippet).
      attr_accessor :additional_context #: String
    end
  end
end
