# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"
require_relative "component"
require_relative "property"
require_relative "service"
require_relative "workflow"

# Formula - Describes workflows and resources that captures rules and other aspects of how the associated BOM component or service was formed.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Formula
      class Formula < Base
        # BOM Reference - An optional identifier which can be used to reference the formula elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Components - Transient components that are used in tasks that constitute one or more of this formula's workflows
        prop :components, :array, items: Component, unique: true
        # Services - Transient services that are used in tasks that constitute one or more of this formula's workflows
        prop :services, :array, items: Service, unique: true
        # Workflows - List of workflows that can be declared to accomplish specific orchestrated goals and independently triggered.
        prop :workflows, :array, items: Workflow, unique: true
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property, unique: true
      end
    end
  end
end
