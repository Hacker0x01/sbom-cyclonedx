# frozen_string_literal: true
# rbs_inline: enabled

# SWID Tag - Specifies metadata and content for ISO-IEC 19770-2 Software Identification (SWID) Tags.
module SBOM
  module CycloneDX
    SWID = SchemaObject.build("SWID") do
      # Tag ID - Maps to the tagId of a SoftwareIdentity.
      prop :tag_id, String, required: true

      # Name - Maps to the name of a SoftwareIdentity.
      prop :name, String, required: true

      # Version - Maps to the version of a SoftwareIdentity.
      prop :version, String, default: "0.0"

      # Tag Version - Maps to the tagVersion of a SoftwareIdentity.
      prop :tag_version, Integer, default: 0

      # Patch - Maps to the patch of a SoftwareIdentity.
      prop :patch, :bool, default: false

      # Attachment text - Specifies the metadata and content of the SWID tag.
      prop :text, Attachment

      # URL - The URL to the SWID file.
      prop :url, URI
    end
  end
end
