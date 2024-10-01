# frozen_string_literal: true
# rbs_inline: enabled

# Advisory - Title and location where advisory information can be obtained. An advisory is a notification of a threat to a component, service, or system.
module SBOM
  module Cyclonedx
    module Constrained
      # Identifier for referable and therefore interlinkable elements. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      class RefLink < String
        def initialize(value)
          raise ArgumentError, 'RefLink must not start with "urn:cdx:"' if value.start_with?("urn:cdx:")
          raise ArgumentError, "RefLink must not be empty" if value.empty?

          super(value)
        end
      end

      # BOM-Link Document - Descriptor for a BOM document. See https://cyclonedx.org/capabilities/bomlink/
      class BOMLinkDocument < String
        REGEX = %r{\Aurn:cdx:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[1-9][0-9]*\Z}

        def initialize(value)
          raise ArgumentError, "BOMLinkDocument must match the regex #{REGEX}" unless value.match?(REGEX)

          super(value)
        end
      end

      # BOM-Link Element - Descriptor for an element in a BOM document. See https://cyclonedx.org/capabilities/bomlink/
      class BOMLinkElement < String
        REGEX = %r{\Aurn:cdx:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[1-9][0-9]*#.+\Z}

        def initialize(value)
          raise ArgumentError, "BOMLinkElement must match the regex #{REGEX}" unless value.match?(REGEX)

          super(value)
        end
      end

      # Mime-Type - The optional mime-type of the component. When used on file components, the mime-type can provide additional context about the kind of file being represented, such as an image, font, or executable. Some library or framework components may also have an associated mime-type.
      # TODO: Use some MimeType Gem
      class MimeType < String
        REGEX = %r{\A[-+a-z0-9.]+/[-+a-z0-9.]+\Z}

        def initialize(value)
          raise ArgumentError, "MimeType must match the regex #{REGEX}" unless value.match?(REGEX)

          super(value)
        end
      end

      # ContentType - Specifies the format and nature of the data being attached, helping systems correctly interpret and process the content. Common content type examples include `application/json` for JSON data and `text/plain` for plan text documents. [RFC 2045 section 5.1](https://www.ietf.org/rfc/rfc2045.html#section-5.1) outlines the structure and use of content types. For a comprehensive list of registered content types, refer to the [IANA media types registry](https://www.iana.org/assignments/media-types/media-types.xhtml).
      # TODO: Use some ContentType gem
      class ContentType < String
        REGEXP = %r{
          \A
          ([0-9A-Za-z!#$%&'*+.^_`|~-]+|x-(?:[0-9A-Za-z!#$%&'*+.^_`|~-]+))
          /
          ([0-9A-Za-z!#$%&'*+.^_`|~-]+)
          ((?:[ \t]*;[ \t]*[0-9A-Za-z!#$%&'*+.^_`|~-]+=(?:[0-9A-Za-z!#$%&'*+.^_`|~-]+|"(?:[^"\\\\]|\\.)*"))*)
          \Z
        }x

        def initialize(value)
          raise ArgumentError, "ContentType must match the regex #{REGEX}" unless value.match?(REGEX)

          super(value)
        end
      end

      # Hash Value - The value of the hash.
      class HashValue < String
        REGEX = /\A([a-fA-F0-9]{32}|[a-fA-F0-9]{40}|[a-fA-F0-9]{64}|[a-fA-F0-9]{96}|[a-fA-F0-9]{128})\Z/

        def initialize(value)
          raise ArgumentError, "HashValue must match the regex #{REGEX}" unless value.match?(REGEX)

          super(value)
        end
      end

      # Locale - Defines a syntax for representing two character language code (ISO-639) followed by an optional two character country code. The language code must be lower case. If the country code is specified, the country code must be upper case. The language code and country code must be separated by a minus sign. Examples: en, en-US, fr, fr-CA
      # TODO: Use some Locale gem
      class Locale < String
        REGEX = /\A([a-z]{2})(-[A-Z]{2})\Z/

        def initialize(value)
          raise ArgumentError, "Locale must match the regex #{REGEX}" unless value.match?(REGEX)

          super(value)
        end
      end
    end
  end
end
