# frozen_string_literal: true
# rbs_inline: enabled

# SWID Tag - Specifies metadata and content for ISO-IEC 19770-2 Software Identification (SWID) Tags.
module Sbom
  module Cyclonedx
    class Swid < SchemaObject
      # Tag ID - Maps to the tagId of a SoftwareIdentity.
      attr_accessor :tag_id #: String

      # Name - Maps to the name of a SoftwareIdentity.
      attr_accessor :name #: String

      # Version - Maps to the version of a SoftwareIdentity.
      attr_accessor :version #: String

      # Tag Version - Maps to the tagVersion of a SoftwareIdentity.
      attr_accessor :tag_version #: Integer

      # Patch - Maps to the patch of a SoftwareIdentity.
      attr_accessor :patch #: bool

      # Attachment text - Specifies the metadata and content of the SWID tag.
      attr_accessor :text #: Attachment

      # URL - The URL to the SWID file.
      attr_accessor :url #: URI

      default :version, "0.0"
      default :tag_version, 0
      default :patch, false
    end
  end
end
