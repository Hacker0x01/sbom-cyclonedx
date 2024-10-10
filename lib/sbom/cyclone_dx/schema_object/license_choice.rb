# frozen_string_literal: true
# rbs_inline: enabled

module SBOM
  module CycloneDX
    LicenseChoice = { one_of: [[WrappedLicense], [LicenseExpression]] }.freeze # rubocop:disable Naming/ConstantName
    LICENSE_CHOICE_VALIDATOR = lambda { |value|
      next [] if value.nil?
      next [] if value.all? { |v| v.all?(WrappedLicense) || (v.first.is_a?(LicenseExpression) && v.length == 1) }

      ["Each element must be an array of licenses or a single-element array containing a LicenseExpression"]
    }

    LicenseExpression = SchemaObject.build("LicenseExpression") do
      # SPDX License Expression - A valid SPDX license expression Refer to https://spdx.org/specifications for syntax requirements
      # Examples:
      #   "Apache-2.0 AND (MIT OR GPL-2.0-only)"
      #   "GPL-3.0-only WITH Classpath-exception-2.0"
      # TODO: Validate syntax
      prop :expression, String, required: true

      prop :acknowledgement, String, enum: Enum::LICENSE_ACKNOWLEDGEMENT

      # BOM Reference - An optional identifier which can be used to reference the license elsewhere in the BOM. Every bom-ref must be unique within the BOM Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK
    end

    WrappedLicense = SchemaObject.build("WrappedLicense") do
      # License - The license information for the BOM document. This may be different from the license(s) of the component(s) that the BOM describes.
      prop :license, License, required: true
    end
  end
end
