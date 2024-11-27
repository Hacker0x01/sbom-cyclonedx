# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "license"

module SBOM
  module CycloneDX
    module Record
      module LicenseChoice
        # Schema name: LicenseExpression
        class LicenseExpression < Base
          # SPDX License Expression - A valid SPDX license expression Refer to https://spdx.org/specifications for syntax requirements
          # Examples:
          #   "Apache-2.0 AND (MIT OR GPL-2.0-only)"
          #   "GPL-3.0-only WITH Classpath-exception-2.0"
          # TODO: Validate syntax
          prop :expression, :string, required: true
          prop :acknowledgement, :string, enum: Enum::LICENSE_ACKNOWLEDGEMENT
          # BOM Reference - An optional identifier which can be used to reference the license elsewhere in the BOM. Every bom-ref must be unique within the BOM Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
          prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        end

        # Schema name: WrappedLicense
        class WrappedLicense < Base
          # License - The license information for the BOM document. This may be different from the license(s) of the component(s) that the BOM describes.
          prop :license, License, required: true
        end

        UNION_TYPE = [LicenseExpression, WrappedLicense].freeze #: [singleton(LicenseExpression), singleton(WrappedLicense)]
      end
    end
  end
end
