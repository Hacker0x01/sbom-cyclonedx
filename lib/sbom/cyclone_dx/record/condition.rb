# frozen_string_literal: true

require_relative "base"

# Condition - A condition that was used to determine a trigger should be activated.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Condition
      class Condition < Base
        # Description - Describes the set of conditions which cause the trigger to activate.
        prop :description, :string
        # Expression - The logical expression that was evaluated that determined the trigger should be fired.
        prop :expression, :string
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
