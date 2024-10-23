# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"
require_relative "component"
require_relative "property"
require_relative "service"
require_relative "workflow"

# Formula - Describes workflows and resources that captures rules and other aspects of how the associated BOM component or service was formed.
module SBOM
  module CycloneDX
    class Formula < Struct.new(
      "Formula",
      # BOM Reference - An optional identifier which can be used to reference the formula elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Components - Transient components that are used in tasks that constitute one or more of this formula's workflows
      :components,
      # Services - Transient services that are used in tasks that constitute one or more of this formula's workflows
      :services,
      # Workflows - List of workflows that can be declared to accomplish specific orchestrated goals and independently triggered.
      :workflows,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def valid?
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(Array, components, unique: true, items: Component) &&
          Validator.valid?(Array, services, unique: true, items: Service) &&
          Validator.valid?(Array, workflows, unique: true, items: Workflow) &&
          Validator.valid?(Array, properties, unique: true, items: Property)
      end
    end
  end
end
