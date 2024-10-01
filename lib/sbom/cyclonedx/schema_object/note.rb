# frozen_string_literal: true
# rbs_inline: enabled

# Note - A note containing the locale and content.
module SBOM
  module Cyclonedx
    class Note < SchemaObject
      # Locale - The ISO-639 (or higher) language code and optional ISO-3166 (or higher) country code. Examples include: "en", "en-US", "fr" and "fr-CA"
      attr_accessor :locale #: Locale

      # Release note content - Specifies the full content of the release note.
      attr_accessor :text #: Attachment
    end
  end
end
