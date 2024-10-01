# frozen_string_literal: true
# rbs_inline: enabled

# Formula - Describes workflows and resources that captures rules and other aspects of how the associated BOM component or service was formed.
module SBOM
  module Cyclonedx
    class Formula < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the formula elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Components - Transient components that are used in tasks that constitute one or more of this formula's workflows
      attr_accessor :components #: Set[Component]

      # Services - Transient services that are used in tasks that constitute one or more of this formula's workflows
      attr_accessor :services #: Set[Service]

      # Workflows - List of workflows that can be declared to accomplish specific orchestrated goals and independently triggered.
      attr_accessor :workflows #: Set[Workflow]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
