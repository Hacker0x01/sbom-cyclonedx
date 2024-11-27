# frozen_string_literal: true

require_relative "base"

# Lightweight name-value pair - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Property
      class Property < Base
        # Name - The name of the property. Duplicate names are allowed, each potentially having a different value.
        prop :name, :string, required: true
        # Value - The value of the property.
        prop :value, :string
      end
    end
  end
end
