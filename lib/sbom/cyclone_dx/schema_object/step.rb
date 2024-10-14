# frozen_string_literal: true

require_relative "../schema_object"

# Executes specific commands or tools in order to accomplish its owning task as part of a sequence.
module SBOM
  module CycloneDX
    class Step < Struct.new(
      "Step",
      # Name - A name for the step.
      :name,
      # Description - A description of the step.
      :description,
      # Commands - Ordered list of commands or directives for the step
      :commands,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, name) &&
          Validator.valid?(String, description) &&
          Validator.valid?(Array, commands, items: Command) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
