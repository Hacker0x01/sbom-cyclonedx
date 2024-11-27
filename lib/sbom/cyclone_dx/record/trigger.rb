# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "condition"
require_relative "event"
require_relative "input"
require_relative "output"
require_relative "property"
require_relative "resource_reference_choice"

# Trigger - Represents a resource that can conditionally activate (or fire) tasks based upon associated events and their data.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Trigger
      class Trigger < Base
        # BOM Reference - An optional identifier which can be used to reference the trigger elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref", required: true
        # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
        prop :uid, :string, required: true
        # Name - The name of the resource instance.
        prop :name, :string
        # Description - A description of the resource instance.
        prop :description, :string
        # Resource references - References to component or service resources that are used to realize the resource instance.
        prop :resource_references, :array, items: ResourceReferenceChoice, unique: true
        # Type - The source type of event which caused the trigger to fire.
        prop :type, :string, enum: Enum::TRIGGER_TYPE, required: true
        # Event - The event data that caused the associated trigger to activate.
        prop :event, Event
        # Conditions - A list of conditions used to determine if a trigger should be activated.
        prop :conditions, :array, items: Condition, unique: true
        # Time activated - The date and time (timestamp) when the trigger was activated.
        prop :time_activated, :date_time
        # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
        # Example: "a `configuration` file which was declared as a local `component` or `externalReference`"
        prop :inputs, :array, items: Input, unique: true
        # Outputs - Represents resources and data output from a task at runtime by executor or task commands
        # Examples: "a log file or metrics data produced by the task"
        prop :outputs, :array, items: Output, unique: true
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
