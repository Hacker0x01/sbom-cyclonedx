# frozen_string_literal: true

module SBOM
  module CycloneDX
    module Pattern
      # While we currently only support Regexp patterns, this may change in the future. Some of the relevant
      # standards/specifications use BNF grammars, which may not be representable as Regexp patterns.

      UUID = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

      CDX_URN_FRAGMENT = %r{([a-z0-9._~!$&'()*+,;=:@/?-]|%[0-9a-f][0-9a-f])+}i
      CDX_BOM_VERSION = /[1-9][0-9]*/
      CDX_URN_NSS = %r{#{UUID}/#{CDX_BOM_VERSION}}
      CDX_URN_ASSIGNED_NAME = /urn:cdx:#{CDX_URN_NSS}/
      CDX_URN = /#{CDX_URN_ASSIGNED_NAME}(##{CDX_URN_FRAGMENT})?/

      BOM_SERIAL_NUMBER = /urn:uuid:#{UUID}/

      CDX_URN_WITH_FRAGMENT = /#{CDX_URN_ASSIGNED_NAME}##{CDX_URN_FRAGMENT}/
      REF_LINK = /(?!urn:cdx:)#{CDX_URN_FRAGMENT}+/
      REF_OR_CDX_URN = /(#{REF_LINK}|#{CDX_URN_WITH_FRAGMENT})/

      HASH_VALUE = /([a-fA-F0-9]{32}|[a-fA-F0-9]{40}|[a-fA-F0-9]{64}|[a-fA-F0-9]{96}|[a-fA-F0-9]{128})/
      LOCALE = /([a-z]{2})(-[A-Z]{2})?/
      MIME_TYPE = %r{[-+a-z0-9.]+/[-+a-z0-9.]+}
      OPEN_CRE = /CRE:[0-9]+-[0-9]+/

      CONTENT_TYPE = %r{
        ([0-9A-Za-z!#$%&'*+.^_`|~-]+|x-(?:[0-9A-Za-z!#$%&'*+.^_`|~-]+))
        /
        ([0-9A-Za-z!#$%&'*+.^_`|~-]+)
        ((?:[ \t]*;[ \t]*[0-9A-Za-z!#$%&'*+.^_`|~-]+=(?:[0-9A-Za-z!#$%&'*+.^_`|~-]+|"(?:[^"\\]|\\.)*"))*)
      }x

      # This is used when no patern is provided for validation
      DEFAULT = /.*/m

      def self.match_exactly?(pattern, value)
        /\A#{pattern}\z/.match?(value)
      end
    end
  end
end
