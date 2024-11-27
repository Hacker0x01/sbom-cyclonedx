# frozen_string_literal: true

require_relative "base"
require_relative "command"
require_relative "property"

# Executes specific commands or tools in order to accomplish its owning task as part of a sequence.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Step
      class Step < Base
        # Name - A name for the step.
        prop :name, :string
        # Description - A description of the step.
        prop :description, :string
        # Commands - Ordered list of commands or directives for the step
        prop :commands, :array, items: Command
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
