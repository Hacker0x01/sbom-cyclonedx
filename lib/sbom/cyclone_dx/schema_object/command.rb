# frozen_string_literal: true

require_relative "../schema_object"

# Anonymous class from Command
module SBOM
  module CycloneDX
    class Command < Struct.new(
      "Command",
      # Executed - A text representation of the executed command.
      :executed,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, executed) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
