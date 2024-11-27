# frozen_string_literal: true

require_relative "base"

# Anonymous class from Command
module SBOM
  module CycloneDX
    module Record
      # Schema name: Command
      class Command < Base
        # Executed - A text representation of the executed command.
        prop :executed, :string
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
