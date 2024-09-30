# frozen_string_literal: true
# rbs_inline: enabled

# Input type - Type that represents various input data types and formats.
module Sbom
  module Cyclonedx
    class InputType < SchemaObject
      # Source - A reference to the component or service that provided the input to the task (e.g., reference to a service with data flow value of `inbound`)
      attr_accessor :source #: ResourceReferenceChoice

      # Target - A reference to the component or service that received or stored the input if not the task itself (e.g., a local, named storage workspace)
      attr_accessor :target #: ResourceReferenceChoice

      # Resource - A reference to an independent resource provided as an input to a task by the workflow runtime.
      attr_accessor :resource #: ResourceReferenceChoice

      # Parameters - Inputs that have the form of parameters with names and values.
      attr_accessor :parameters #: Set[Parameter]

      # Environment variables - Inputs that have the form of parameters with names and values.
      attr_accessor :environment_vars #: Set[Property | String]

      # Data - Inputs that have the form of data.
      attr_accessor :data #: Attachment

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
