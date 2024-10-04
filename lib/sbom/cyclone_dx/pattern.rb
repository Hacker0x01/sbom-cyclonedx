# frozen_string_literal: true
# rbs_inline: enabled

# Advisory - Title and location where advisory information can be obtained. An advisory is a notification of a threat to a component, service, or system.
module SBOM
  module CycloneDX
    module Pattern
      UUID = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\Z/
      URN_UUID = /\Aurn:uuid:#{UUID}\Z/

      REF_LINK = /\A(?!urn:cdx:).+\Z/
      BOM_LINK_DOCUMENT = %r{\Aurn:cdx:#{UUID}/[1-9][0-9]*\Z}
      BOM_LINK_ELEMENT = /\A#{BOM_LINK_DOCUMENT}#.+\Z/
      BOM_LINK = /\A(#{BOM_LINK_DOCUMENT}|#{BOM_LINK_ELEMENT})\Z/
      REF_LINK_OR_BOM_LINK_ELEMENT = /\A(#{REF_LINK}|#{BOM_LINK_ELEMENT})\Z/

      HASH_VALUE = /\A([a-fA-F0-9]{32}|[a-fA-F0-9]{40}|[a-fA-F0-9]{64}|[a-fA-F0-9]{96}|[a-fA-F0-9]{128})\Z/
      LOCALE = /\A([a-z]{2})(-[A-Z]{2})\Z/
      MIME_TYPE = %r{\A[-+a-z0-9.]+/[-+a-z0-9.]+\Z}
      OPEN_CRE = /\ACRE:[0-9]+-[0-9]+\Z/

      CONTENT_TYPE = %r{
        \A
        ([0-9A-Za-z!#$%&'*+.^_`|~-]+|x-(?:[0-9A-Za-z!#$%&'*+.^_`|~-]+))
        /
        ([0-9A-Za-z!#$%&'*+.^_`|~-]+)
        ((?:[ \t]*;[ \t]*[0-9A-Za-z!#$%&'*+.^_`|~-]+=(?:[0-9A-Za-z!#$%&'*+.^_`|~-]+|"(?:[^"\\\\]|\\.)*"))*)
        \Z
      }x
    end
  end
end
