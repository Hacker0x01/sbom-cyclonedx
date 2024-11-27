# frozen_string_literal: true

require_relative "../enum"
require_relative "base"

# Version
module SBOM
  module CycloneDX
    module Record
      # Schema name: Version
      class Version < Base
        # Version - A single version of a component or service.
        prop :version, :string, max_length: 1024
        # Version Range - A version range specified in Package URL Version Range syntax (vers) which is defined at https://github.com/package-url/purl-spec/blob/master/VERSION-RANGE-SPEC.rst
        # TODO: Validate syntax
        prop :range, :string, max_length: 4096, min_length: 1
        # Status - The vulnerability status for the version or range of versions.
        prop :status, :string, enum: Enum::AFFECTED_STATUS

        validate :version, :range, presence: :any
      end
    end
  end
end
