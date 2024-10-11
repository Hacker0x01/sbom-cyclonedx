# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Definitions - A collection of reusable objects that are defined and may be used elsewhere in the BOM.
module SBOM
  module CycloneDX
    class Definitions < Struct.new(
      "Definitions",
      # Standards - The list of standards which may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to.
      :standards,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(Array, standards, items: Standard)
      end
    end
  end
end
