# frozen_string_literal: true

require_relative "../enum"
require_relative "../schema_object"

# Anonymous class from Output
module SBOM
  module CycloneDX
    class Output < Struct.new(
      "Output",
      # Type - Describes the type of data output.
      :type,
      # Source - Component or service that generated or provided the output from the task (e.g., a build tool)
      :source,
      # Target - Component or service that received the output from the task (e.g., reference to an artifactory service with data flow value of `outbound`)
      :target,
      # Resource - A reference to an independent resource generated as output by the task.
      :resource,
      # Data - Outputs that have the form of data.
      :data,
      # Environment variables - Outputs that have the form of environment variables.
      :environment_vars,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def initialize(type:, source: nil, target: nil, resource: nil, data: nil, environment_vars: nil, properties: nil)
        if [resource, data, environment_vars].none?
          raise ArgumentError, "At least one of `resource`, `data`, or `environment_vars` must be provided"
        end

        super
      end

      def valid?
        Validator.valid?(String, type, enum: Enum::OUTPUT_TYPE, required: true) &&
          Validator.valid?(ResourceReferenceChoice, source) &&
          Validator.valid?(ResourceReferenceChoice, target) &&
          Validator.valid?(ResourceReferenceChoice, resource, required: [data, environment_vars].none?) &&
          Validator.valid?(Attachment, data, required: [resource, environment_vars].none?) &&
          Validator.valid?(
            Array,
            environment_vars,
            unique: true,
            items: [SBOM::CycloneDX::Type::Union, klasses: [Property, String]],
            required: [resource, data].none?
          ) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
