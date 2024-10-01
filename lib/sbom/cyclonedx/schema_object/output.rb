# frozen_string_literal: true
# rbs_inline: enabled

# Anonymous class from Output
module SBOM
  module Cyclonedx
    class Output < SchemaObject
      # Type - Describes the type of data output.
      attr_accessor :type #: OutputType

      # Source - Component or service that generated or provided the output from the task (e.g., a build tool)
      attr_accessor :source #: ResourceReferenceChoice

      # Target - Component or service that received the output from the task (e.g., reference to an artifactory service with data flow value of `outbound`)
      attr_accessor :target #: ResourceReferenceChoice

      # Resource - A reference to an independent resource generated as output by the task.
      attr_accessor :resource #: ResourceReferenceChoice

      # Data - Outputs that have the form of data.
      attr_accessor :data #: Attachment

      # Environment variables - Outputs that have the form of environment variables.
      attr_accessor :environment_vars #: Set[Property | String]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
