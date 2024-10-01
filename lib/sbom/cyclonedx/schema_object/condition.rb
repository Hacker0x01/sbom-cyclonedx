# frozen_string_literal: true
# rbs_inline: enabled

# Condition - A condition that was used to determine a trigger should be activated.
module SBOM
  module Cyclonedx
    class Condition < SchemaObject
      # Description - Describes the set of conditions which cause the trigger to activate.
      attr_accessor :description #: String

      # Expression - The logical expression that was evaluated that determined the trigger should be fired.
      attr_accessor :expression #: String

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
