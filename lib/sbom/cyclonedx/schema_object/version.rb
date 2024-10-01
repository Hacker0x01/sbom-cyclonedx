# frozen_string_literal: true
# rbs_inline: enabled

# Version
module SBOM
  module Cyclonedx
    class Version < SchemaObject
      # Version - A single version of a component or service.
      attr_accessor :version #: String

      validate :version, required: -> { range.nil? }, max_length: 1024

      # Version Range - A version range specified in Package URL Version Range syntax (vers) which is defined at https://github.com/package-url/purl-spec/blob/master/VERSION-RANGE-SPEC.rst
      # TODO: Validate syntax
      attr_accessor :range #: String

      validate :range, required: -> { version.nil? }, min_length: 1, max_length: 4096

      # Status - The vulnerability status for the version or range of versions.
      attr_accessor :status #: AffectedStatus

      default :status, AffectedStatus::AFFECTED
    end
  end
end
