# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Trigger - Represents a resource that can conditionally activate (or fire) tasks based upon associated events and their data.
module SBOM
  module CycloneDX
    class Trigger < Struct.new(
      "Trigger",
      # BOM Reference - An optional identifier which can be used to reference the trigger elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
      :uid,
      # Name - The name of the resource instance.
      :name,
      # Description - A description of the resource instance.
      :description,
      # Resource references - References to component or service resources that are used to realize the resource instance.
      :resource_references,
      # Type - The source type of event which caused the trigger to fire.
      :type,
      # Event - The event data that caused the associated trigger to activate.
      :event,
      # Conditions - A list of conditions used to determine if a trigger should be activated.
      :conditions,
      # Time activated - The date and time (timestamp) when the trigger was activated.
      :time_activated,
      # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
      # Example: "a `configuration` file which was declared as a local `component` or `externalReference`"
      :inputs,
      # Outputs - Represents resources and data output from a task at runtime by executor or task commands
      # Examples: "a log file or metrics data produced by the task"
      :outputs,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def initialize(
        bom_ref:,
        uid:,
        type:,
        name: nil,
        description: nil,
        resource_references: nil,
        event: nil,
        conditions: nil,
        time_activated: nil,
        inputs: nil,
        outputs: nil,
        properties: nil
      )
        super
      end

      def valid? # rubocop:disable Metrics/PerceivedComplexity
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK, required: true) &&
          Validator.valid?(String, uid, required: true) &&
          Validator.valid?(String, name) &&
          Validator.valid?(String, description) &&
          Validator.valid?(Array, resource_references, unique: true, items: ResourceReferenceChoice) &&
          Validator.valid?(String, type, enum: Enum::TRIGGER_TYPE, required: true) &&
          Validator.valid?(Event, event) &&
          Validator.valid?(Array, conditions, unique: true, items: Condition) &&
          Validator.valid?(DateTime, time_activated) &&
          Validator.valid?(Array, inputs, unique: true, items: Input) &&
          Validator.valid?(Array, outputs, unique: true, items: Output) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
