# frozen_string_literal: true
# rbs_inline: enabled

# Attachment - Specifies the metadata and content for an attachment.
module SBOM
  module Cyclonedx
    class Attachment < SchemaObject
      # Content-Type - Specifies the format and nature of the data being attached, helping systems correctly interpret and process the content. Common content type examples include `application/json` for JSON data and `text/plain` for plan text documents.  [RFC 2045 section 5.1](https://www.ietf.org/rfc/rfc2045.html#section-5.1) outlines the structure and use of content types. For a comprehensive list of registered content types, refer to the [IANA media types registry](https://www.iana.org/assignments/media-types/media-types.xhtml).
      # TODO: Validate
      attr_accessor :content_type #: String

      default :content_type, "text/plain"

      # Attachment Text - The attachment data. Proactive controls such as input validation and sanitization should be employed to prevent misuse of attachment text.
      attr_accessor :content #: String

      validate :content, required: true

      # Encoding - Specifies the optional encoding the text is represented in.
      def encoding
        # Base64 is a binary-to-text encoding scheme that represents binary data in an ASCII string.
        "base64"
      end
    end
  end
end
