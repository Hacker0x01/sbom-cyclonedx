# frozen_string_literal: true

require_relative "../schema_object"

# Condition - A condition that was used to determine a trigger should be activated.
module SBOM
  module CycloneDX
    class Condition < Struct.new(
      "Condition",
      # Description - Describes the set of conditions which cause the trigger to activate.
      :description,
      # Expression - The logical expression that was evaluated that determined the trigger should be fired.
      :expression,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, description) &&
          Validator.valid?(String, expression) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
