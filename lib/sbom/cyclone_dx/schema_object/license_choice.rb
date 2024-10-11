# frozen_string_literal: true

module SBOM
  module CycloneDX
    module LicenseChoice
      def self.valid?(object, **type_specific_args)
        Validator.valid?(Union, object, klasses: [LicenseExpression, WrappedLicense], **type_specific_args)
      end

      class LicenseExpression < Struct.new(
        "LicenseExpression",
        # SPDX License Expression - A valid SPDX license expression Refer to https://spdx.org/specifications for syntax requirements
        # Examples:
        #   "Apache-2.0 AND (MIT OR GPL-2.0-only)"
        #   "GPL-3.0-only WITH Classpath-exception-2.0"
        # TODO: Validate syntax
        :expression,
        :acknowledgement,
        # BOM Reference - An optional identifier which can be used to reference the license elsewhere in the BOM. Every bom-ref must be unique within the BOM Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        :bom_ref,
        keyword_init: true
      )
        include SchemaObject

        json_name :bom_ref, "bom-ref"

        def initialize(
          expression:,
          acknowledgement: nil,
          bom_ref: nil
        )
          super
        end

        def valid?
          Validator.valid?(String, expression, required: true) &&
            Validator.valid?(String, acknowledgement, enum: Enum::LICENSE_ACKNOWLEDGEMENT) &&
            Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK)
        end
      end

      class WrappedLicense < Struct.new(
        "WrappedLicense",
        # License - The license information for the BOM document. This may be different from the license(s) of the component(s) that the BOM describes.
        :license,
        keyword_init: true
      )
        include SchemaObject

        def initialize(license:)
          super(license: license)
        end

        def valid?
          Validator.valid?(License, license, required: true)
        end
      end
    end
  end
end
