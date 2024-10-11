# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Version
module SBOM
  module CycloneDX
    class Version < Struct.new(
      "Version",
      # Version - A single version of a component or service.
      :version,
      # Version Range - A version range specified in Package URL Version Range syntax (vers) which is defined at https://github.com/package-url/purl-spec/blob/master/VERSION-RANGE-SPEC.rst
      # TODO: Validate syntax
      :range,
      # Status - The vulnerability status for the version or range of versions.
      :status,
      keyword_init: true
    )
      include SchemaObject

      def initialize(version: nil, range: nil, status: "affected")
        raise ArgumentError, "version or range must be provided" if version.nil? && range.nil?

        super
      end

      def valid?
        Validator.valid?(String, version, max_length: 1024, required: range.nil?) &&
          Validator.valid?(String, range, min_length: 1, max_length: 4096, required: version.nil?) &&
          Validator.valid?(String, status, enum: Enum::AFFECTED_STATUS)
      end
    end
  end
end
