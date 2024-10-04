# frozen_string_literal: true
# rbs_inline: enabled

# Anonymous class from Output
module SBOM
  module CycloneDX
    Output = SchemaObject.build("Output") do
      # Type - Describes the type of data output.
      prop :type, String, enum: Enum::OUTPUT_TYPE

      # Source - Component or service that generated or provided the output from the task (e.g., a build tool)
      prop :source, ResourceReferenceChoice

      # Target - Component or service that received the output from the task (e.g., reference to an artifactory service with data flow value of `outbound`)
      prop :target, ResourceReferenceChoice

      # Resource - A reference to an independent resource generated as output by the task.
      prop :resource, ResourceReferenceChoice, required: -> { environment_vars.nil? && data.nil? }

      # Data - Outputs that have the form of data.
      prop :data, Attachment, required: -> { resource.nil? && environment_vars.nil? }

      # Environment variables - Outputs that have the form of environment variables.
      prop :environment_vars, Set[one_of: [Property, String]], required: -> { resource.nil? && data.nil? }

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      prop :properties, [Property]
    end
  end
end
