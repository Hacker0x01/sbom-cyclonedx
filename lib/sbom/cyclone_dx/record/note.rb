# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"
require_relative "attachment"

# Note - A note containing the locale and content.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Note
      class Note < Base
        # Locale - The ISO-639 (or higher) language code and optional ISO-3166 (or higher) country code. Examples include: "en", "en-US", "fr" and "fr-CA"
        prop :locale, :string, pattern: Pattern::LOCALE
        # Release note content - Specifies the full content of the release note.
        prop :text, Attachment, required: true
      end
    end
  end
end
