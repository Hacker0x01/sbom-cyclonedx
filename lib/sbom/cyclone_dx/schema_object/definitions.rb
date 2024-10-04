# frozen_string_literal: true
# rbs_inline: enabled

# Definitions - A collection of reusable objects that are defined and may be used elsewhere in the BOM.
module SBOM
  module CycloneDX
    Definitions = SchemaObject.build("Definitions") do
      # Standards - The list of standards which may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to.
      prop :standards, [Standard]
    end
  end
end
