# frozen_string_literal: true

require_relative "base"
require_relative "standard"

# Definitions - A collection of reusable objects that are defined and may be used elsewhere in the BOM.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Definitions
      class Definitions < Base
        # Standards - The list of standards which may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to.
        prop :standards, :array, items: Standard
      end
    end
  end
end
