# frozen_string_literal: true

require_relative "../schema_object"

# Diff - The patch file (or diff) that shows changes. Refer to https://en.wikipedia.org/wiki/Diff
module SBOM
  module CycloneDX
    class Diff < Struct.new(
      "Diff",
      # Diff text - Specifies the optional text of the diff
      :text,
      # URL - Specifies the URL to the diff
      :url,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(Attachment, text) &&
          Validator.valid?(URI, url)
      end
    end
  end
end
