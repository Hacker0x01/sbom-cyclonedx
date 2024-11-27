# frozen_string_literal: true

require_relative "base"
require_relative "resource_reference_choice"
require_relative "parameter"
require_relative "property"
require_relative "attachment"

# Input type - Type that represents various input data types and formats.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Input
      class Input < Base
        # Source - A reference to the component or service that provided the input to the task (e.g., reference to a service with data flow value of `inbound`)
        prop :source, ResourceReferenceChoice
        # Target - A reference to the component or service that received or stored the input if not the task itself (e.g., a local, named storage workspace)
        prop :target, ResourceReferenceChoice
        # Resource - A reference to an independent resource provided as an input to a task by the workflow runtime.
        prop :resource, ResourceReferenceChoice
        # Parameters - Inputs that have the form of parameters with names and values.
        prop :parameters, :array, items: Parameter, unique: true
        # Environment variables - Inputs that have the form of parameters with names and values.
        prop :environment_vars, :array, items: [:union, of: [Property, :string]], unique: true
        # Data - Inputs that have the form of data.
        prop :data, Attachment
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property

        validate :resource, :parameters, :environment_vars, :data, presence: :any
      end
    end
  end
end
