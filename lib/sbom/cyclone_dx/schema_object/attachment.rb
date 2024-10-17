# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"

# Attachment - Specifies the metadata and content for an attachment.
module SBOM
  module CycloneDX
    class Attachment < Struct.new(
      "Attachment",
      # Content-Type - Specifies the format and nature of the data being attached, helping systems correctly interpret and process the content. Common content type examples include `application/json` for JSON data and `text/plain` for plan text documents.  [RFC 2045 section 5.1](https://www.ietf.org/rfc/rfc2045.html#section-5.1) outlines the structure and use of content types. For a comprehensive list of registered content types, refer to the [IANA media types registry](https://www.iana.org/assignments/media-types/media-types.xhtml).
      :content_type,
      # Attachment Text - The attachment data. Proactive controls such as input validation and sanitization should be employed to prevent misuse of attachment text.
      :content,
      # Encoding - Specifies the optional encoding the text is represented in.
      :encoding,
      keyword_init: true
    )
      include SchemaObject

      def initialize(content:, content_type: "text/plain")
        super(content: content, content_type: content_type, encoding: "base64")
      end

      def valid?
        Validator.valid?(String, content_type, pattern: Pattern::CONTENT_TYPE, required: true) &&
          Validator.valid?(String, content, required: true) &&
          Validator.valid?(String, encoding, const: "base64")
      end
    end
  end
end
