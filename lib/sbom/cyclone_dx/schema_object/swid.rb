# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# SWID Tag - Specifies metadata and content for ISO-IEC 19770-2 Software Identification (SWID) Tags.
module SBOM
  module CycloneDX
    class SWID < Struct.new(
      "SWID",
      # Tag ID - Maps to the tagId of a SoftwareIdentity.
      :tag_id,
      # Name - Maps to the name of a SoftwareIdentity.
      :name,
      # Version - Maps to the version of a SoftwareIdentity.
      :version,
      # Tag Version - Maps to the tagVersion of a SoftwareIdentity.
      :tag_version,
      # Patch - Maps to the patch of a SoftwareIdentity.
      :patch,
      # Attachment text - Specifies the metadata and content of the SWID tag.
      :text,
      # URL - The URL to the SWID file.
      :url,
      keyword_init: true
    )
      include SchemaObject

      def initialize( # rubocop:disable Metrics/ParameterLists
        tag_id:,
        name:,
        version: "0.0",
        tag_version: 0,
        patch: false,
        text: nil,
        url: nil
      )
        super
      end

      def valid?
        Validator.valid?(String, tag_id, required: true) &&
          Validator.valid?(String, name, required: true) &&
          Validator.valid?(String, version) &&
          Validator.valid?(Integer, tag_version) &&
          Validator.valid?(Boolean, patch) &&
          Validator.valid?(Attachment, text) &&
          Validator.valid?(URI, url)
      end
    end
  end
end
