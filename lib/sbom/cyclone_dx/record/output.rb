# frozen_string_literal: true

require_relative "../enum"
require_relative "base"
require_relative "resource_reference_choice"
require_relative "attachment"
require_relative "property"

# Anonymous class from Output
module SBOM
  module CycloneDX
    module Record
      # Schema name: Output
      class Output < Base
        # Type - Describes the type of data output.
        prop :type, :string, enum: Enum::OUTPUT_TYPE, required: true
        # Source - Component or service that generated or provided the output from the task (e.g., a build tool)
        prop :source, ResourceReferenceChoice
        # Target - Component or service that received the output from the task (e.g., reference to an artifactory service with data flow value of `outbound`)
        prop :target, ResourceReferenceChoice
        # Resource - A reference to an independent resource generated as output by the task.
        prop :resource, ResourceReferenceChoice
        # Data - Outputs that have the form of data.
        prop :data, Attachment
        # Environment variables - Outputs that have the form of environment variables.
        prop :environment_vars, :array, items: [:union, of: [Property, :string]]
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property

        validate :resource, :data, :environment_vars, presence: :any
      end
    end
  end
end
