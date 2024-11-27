# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"

# Attachment - Specifies the metadata and content for an attachment.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Attachment
      class Attachment < Base
        # Content-Type - Specifies the format and nature of the data being attached, helping systems correctly interpret and process the content. Common content type examples include `application/json` for JSON data and `text/plain` for plan text documents.  [RFC 2045 section 5.1](https://www.ietf.org/rfc/rfc2045.html#section-5.1) outlines the structure and use of content types. For a comprehensive list of registered content types, refer to the [IANA media types registry](https://www.iana.org/assignments/media-types/media-types.xhtml).
        prop :content_type, :string, pattern: Pattern::CONTENT_TYPE, required: true, default: "text/plain"
        # Attachment Text - The attachment data. Proactive controls such as input validation and sanitization should be employed to prevent misuse of attachment text.
        prop :content, :string, required: true
        # Encoding - Specifies the optional encoding the text is represented in.
        const :encoding, :string, "base64"
      end
    end
  end
end
