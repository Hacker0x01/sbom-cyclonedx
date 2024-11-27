# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"
require_relative "external_reference"

# Resource reference choice - A reference to a locally defined resource (e.g., a bom-ref) or an externally accessible resource.
module SBOM
  module CycloneDX
    module Record
      # Schema name: ResourceReferenceChoice
      class ResourceReferenceChoice < Base
        # BOM Reference - References an object by its bom-ref attribute
        prop :ref, :string, pattern: Pattern::REF_OR_CDX_URN
        # External reference - Reference to an externally accessible resource.
        prop :external_reference, ExternalReference

        validate :ref, :external_reference, presence: :any
      end
    end
  end
end
