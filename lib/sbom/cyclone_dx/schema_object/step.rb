# frozen_string_literal: true
# rbs_inline: enabled

# Executes specific commands or tools in order to accomplish its owning task as part of a sequence.
module SBOM
  module CycloneDX
    Step = SchemaObject.build("Step") do
      # Name - A name for the step.
      prop :name, String

      # Description - A description of the step.
      prop :description, String

      # Commands - Ordered list of commands or directives for the step
      prop :commands, [Command]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      prop :properties, [Property]
    end
  end
end
