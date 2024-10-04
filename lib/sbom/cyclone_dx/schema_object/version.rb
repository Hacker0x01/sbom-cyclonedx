# frozen_string_literal: true
# rbs_inline: enabled

# Version
module SBOM
  module CycloneDX
    Version = SchemaObject.build("Version") do
      # Version - A single version of a component or service.
      prop :version, String, required: -> { range.nil? }, max_length: 1024

      # Version Range - A version range specified in Package URL Version Range syntax (vers) which is defined at https://github.com/package-url/purl-spec/blob/master/VERSION-RANGE-SPEC.rst
      # TODO: Validate syntax
      prop :range, String, required: -> { version.nil? }, min_length: 1, max_length: 4096

      # Status - The vulnerability status for the version or range of versions.
      prop :status, String, enum: Enum::AFFECTED_STATUS, default: AffectedStatus::AFFECTED
    end
  end
end
