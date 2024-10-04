# frozen_string_literal: true
# rbs_inline: enabled

# Note - A note containing the locale and content.
module SBOM
  module CycloneDX
    Note = SchemaObject.build("Note") do
      # Locale - The ISO-639 (or higher) language code and optional ISO-3166 (or higher) country code. Examples include: "en", "en-US", "fr" and "fr-CA"
      prop :locale, String, pattern: Pattern::LOCALE

      # Release note content - Specifies the full content of the release note.
      prop :text, Attachment, required: true
    end
  end
end
