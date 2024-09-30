# frozen_string_literal: true
# rbs_inline: enabled

# Version
module Sbom
  module Cyclonedx
    class Version < SchemaObject
      # Version - A single version of a component or service.
      attr_accessor :version #: String

      # Version Range - A version range specified in Package URL Version Range syntax (vers) which is defined at https://github.com/package-url/purl-spec/blob/master/VERSION-RANGE-SPEC.rst
      attr_accessor :range #: VersionRange

      # Status - The vulnerability status for the version or range of versions.
      attr_accessor :status #: AffectedStatus

      def initialize(version: nil, range: nil, status: nil)
        raise "Version must have either a version or a range" if version.nil? && range.nil?

        @version = version
        @range = range
        @status = status

        super
      end
    end
  end
end
