# frozen_string_literal: true
# rbs_inline: enabled

# External Reference - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
module SBOM
  module Cyclonedx
    class ExternalReference < SchemaObject
      # URL - The URI (URL or URN) to the external reference. External references are URIs and therefore can accept any URL scheme including https ([RFC-7230](https://www.ietf.org/rfc/rfc7230.txt)), mailto ([RFC-2368](https://www.ietf.org/rfc/rfc2368.txt)), tel ([RFC-3966](https://www.ietf.org/rfc/rfc3966.txt)), and dns ([RFC-4501](https://www.ietf.org/rfc/rfc4501.txt)). External references may also include formally registered URNs such as [CycloneDX BOM-Link](https://cyclonedx.org/capabilities/bomlink/) to reference CycloneDX BOMs or any object within a BOM. BOM-Link transforms applicable external references into relationships that can be expressed in a BOM or across BOMs.
      attr_accessor :url #: URI | BOMLinkElement | BOMLinkDocument

      # Comment - An optional comment describing the external reference
      attr_accessor :comment #: String

      # Type - Specifies the type of external reference.
      attr_accessor :type #: ExternalReferenceType

      # Hashes - The hashes of the external reference (if applicable).
      attr_accessor :hashes #: [Hash]
    end
  end
end
