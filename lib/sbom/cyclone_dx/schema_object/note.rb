# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Note - A note containing the locale and content.
module SBOM
  module CycloneDX
    class Note < Struct.new(
      "Note",
      # Locale - The ISO-639 (or higher) language code and optional ISO-3166 (or higher) country code. Examples include: "en", "en-US", "fr" and "fr-CA"
      :locale,
      # Release note content - Specifies the full content of the release note.
      :text,
      keyword_init: true
    )
      include SchemaObject

      def initialize(text:, locale: nil)
        super(locale: locale, text: text)
      end

      def valid?
        Validator.valid?(String, locale, pattern: Pattern::LOCALE) &&
          Validator.valid?(Attachment, text, required: true)
      end
    end
  end
end
