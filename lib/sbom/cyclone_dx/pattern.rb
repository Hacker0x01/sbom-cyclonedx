# frozen_string_literal: true

module SBOM
  module CycloneDX
    module Pattern
      # While we currently only support Regexp patterns, this may change in the future. Some of the relevant
      # standards/specifications use BNF grammars, which may not be representable as Regexp patterns.

      UUID = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\Z/

      CDX_URN_FRAGMENT = %r{\A([a-z0-9._~!$&'()*+,;=:@/?-]|%[0-9a-f][0-9a-f])+\Z}i
      CDX_BOM_VERSION = /\A[1-9][0-9]*\Z/
      CDX_URN_NSS = %r{\A#{UUID}/#{CDX_BOM_VERSION}\Z}
      CDX_URN_ASSIGNED_NAME = /\Aurn:cdx:#{CDX_URN_NSS}\Z/
      CDX_URN = /\A#{CDX_URN_ASSIGNED_NAME}(##{CDX_URN_FRAGMENT})?\Z/

      BOM_SERIAL_NUMBER = /\Aurn:uuid:#{UUID}\Z/

      CDX_URN_WITH_FRAGMENT = /\A#{CDX_URN_ASSIGNED_NAME}##{CDX_URN_FRAGMENT}\Z/
      REF_LINK = /\A(?!urn:cdx:)#{CDX_URN_FRAGMENT}+\Z/
      REF_OR_CDX_URN = /\A(#{REF_LINK}|#{CDX_URN_WITH_FRAGMENT})\Z/

      HASH_VALUE = /\A([a-fA-F0-9]{32}|[a-fA-F0-9]{40}|[a-fA-F0-9]{64}|[a-fA-F0-9]{96}|[a-fA-F0-9]{128})\Z/
      LOCALE = /\A([a-z]{2})(-[A-Z]{2})?\Z/
      MIME_TYPE = %r{\A[-+a-z0-9.]+/[-+a-z0-9.]+\Z}
      OPEN_CRE = /\ACRE:[0-9]+-[0-9]+\Z/

      CONTENT_TYPE = %r{
        \A
        ([0-9A-Za-z!#$%&'*+.^_`|~-]+|x-(?:[0-9A-Za-z!#$%&'*+.^_`|~-]+))
        /
        ([0-9A-Za-z!#$%&'*+.^_`|~-]+)
        ((?:[ \t]*;[ \t]*[0-9A-Za-z!#$%&'*+.^_`|~-]+=(?:[0-9A-Za-z!#$%&'*+.^_`|~-]+|"(?:[^"\\]|\\.)*"))*)
        \Z
      }x
    end
  end
end
