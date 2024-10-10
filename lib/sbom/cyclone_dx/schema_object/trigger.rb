# frozen_string_literal: true
# rbs_inline: enabled

# Trigger - Represents a resource that can conditionally activate (or fire) tasks based upon associated events and their data.
module SBOM
  module CycloneDX
    Trigger = SchemaObject.build("Trigger") do
      # BOM Reference - An optional identifier which can be used to reference the trigger elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK, required: true

      # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
      prop :uid, String, required: true

      # Name - The name of the resource instance.
      prop :name, String

      # Description - A description of the resource instance.
      prop :description, String

      # Resource references - References to component or service resources that are used to realize the resource instance.
      prop :resource_references, Set[ResourceReferenceChoice]

      # Type - The source type of event which caused the trigger to fire.
      prop :type, String, enum: Enum::TRIGGER_TYPE, required: true

      # Event - The event data that caused the associated trigger to activate.
      prop :event, Event

      # Conditions - A list of conditions used to determine if a trigger should be activated.
      prop :conditions, Set[Condition]

      # Time activated - The date and time (timestamp) when the trigger was activated.
      prop :time_activated, DateTime

      # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
      # Example: "a `configuration` file which was declared as a local `component` or `externalReference`"
      prop :inputs, Set[Input]

      # Outputs - Represents resources and data output from a task at runtime by executor or task commands
      # Examples: "a log file or metrics data produced by the task"
      prop :outputs, Set[Output]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      prop :properties, [Property]
    end
  end
end
