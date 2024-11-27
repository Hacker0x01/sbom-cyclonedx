# frozen_string_literal: true

require_relative "base"
require_relative "attachment"

# SWID Tag - Specifies metadata and content for ISO-IEC 19770-2 Software Identification (SWID) Tags.
module SBOM
  module CycloneDX
    module Record
      # Schema name: SWID
      class SWID < Base
        # Tag ID - Maps to the tagId of a SoftwareIdentity.
        prop :tag_id, :string, required: true
        # Name - Maps to the name of a SoftwareIdentity.
        prop :name, :string, required: true
        # Version - Maps to the version of a SoftwareIdentity.
        prop :version, :string, default: "0.0"
        # Tag Version - Maps to the tagVersion of a SoftwareIdentity.
        prop :tag_version, :integer, default: 0
        # Patch - Maps to the patch of a SoftwareIdentity.
        prop :patch, :boolean, default: false
        # Attachment text - Specifies the metadata and content of the SWID tag.
        prop :text, Attachment
        # URL - The URL to the SWID file.
        prop :url, :uri
      end
    end
  end
end
