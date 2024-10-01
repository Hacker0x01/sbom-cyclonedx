# frozen_string_literal: true
# rbs_inline: enabled

# SPDX License Expression - A tuple of exactly one SPDX License Expression.
module SBOM
  module Cyclonedx
    class LicenseExpression < SchemaObject
      # SPDX License Expression - A valid SPDX license expression Refer to https://spdx.org/specifications for syntax requirements
      # Examples:
      #   "Apache-2.0 AND (MIT OR GPL-2.0-only)"
      #   "GPL-3.0-only WITH Classpath-exception-2.0"
      # TODO: Validate
      attr_accessor :expression #: String

      attr_accessor :acknowledgement #: LicenseAcknowledgement

      # BOM Reference - An optional identifier which can be used to reference the license elsewhere in the BOM. Every bom-ref must be unique within the BOM Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink
    end
  end
end
