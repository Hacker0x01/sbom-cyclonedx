# frozen_string_literal: true

require_relative "../schema_object"

# Input type - Type that represents various input data types and formats.
module SBOM
  module CycloneDX
    class Input < Struct.new(
      "Input",
      # Source - A reference to the component or service that provided the input to the task (e.g., reference to a service with data flow value of `inbound`)
      :source,
      # Target - A reference to the component or service that received or stored the input if not the task itself (e.g., a local, named storage workspace)
      :target,
      # Resource - A reference to an independent resource provided as an input to a task by the workflow runtime.
      :resource,
      # Parameters - Inputs that have the form of parameters with names and values.
      :parameters,
      # Environment variables - Inputs that have the form of parameters with names and values.
      :environment_vars,
      # Data - Inputs that have the form of data.
      :data,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def initialize(
        source: nil,
        target: nil,
        resource: nil,
        parameters: nil,
        environment_vars: nil,
        data: nil,
        properties: nil
      )
        if [resource, parameters, environment_vars, data].none?
          raise ArgumentError, "One of resource, parameters, environment_vars, or data must be provided"
        end

        super
      end

      def valid?
        Validator.valid?(ResourceReferenceChoice, source) &&
          Validator.valid?(ResourceReferenceChoice, target) &&
          Validator.valid?(ResourceReferenceChoice, resource, required: [parameters, environment_vars, data].none?) &&
          Validator.valid?(
            Array,
            parameters,
            unique: true,
            items: Parameter,
            required: [resource, environment_vars, data].none?
          ) &&
          Validator.valid?(
            Array,
            environment_vars,
            unique: true,
            items: [SBOM::CycloneDX::Type::Union, klasses: [Property, String]],
            required: [resource, parameters, data].none?
          ) &&
          Validator.valid?(Attachment, data, required: [resource, parameters, environment_vars].none?) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
