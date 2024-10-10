# frozen_string_literal: true
# rbs_inline: enabled

# Task - Describes the inputs, sequence of steps and resources used to accomplish a task and its output.
module SBOM
  module CycloneDX
    Task = SchemaObject.build("Task") do
      # BOM Reference - An optional identifier which can be used to reference the task elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK, required: true

      # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
      prop :uid, String, required: true

      # Name - The name of the resource instance.
      prop :name, String

      # Description - A description of the resource instance.
      prop :description, String

      # Resource references - References to component or service resources that are used to realize the resource instance.
      prop :resource_references, Set[ResourceReferenceChoice]

      # Task types - Indicates the types of activities performed by the set of workflow tasks.
      prop :task_types, [String], all: { enum: Enum::TASK_TYPE }, required: true

      # Trigger - The trigger that initiated the task.
      prop :trigger, Trigger

      # Steps - The sequence of steps for the task.
      prop :steps, Set[Step]

      # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
      # Example: "a `configuration` file which was declared as a local `component` or `externalReference`"
      prop :inputs, Set[Input]

      # Outputs - Represents resources and data output from a task at runtime by executor or task commands
      # Example: "a log file or metrics data produced by the task"
      prop :outputs, Set[Output]

      # Time start - The date and time (timestamp) when the task started.
      prop :time_start, DateTime

      # Time end - The date and time (timestamp) when the task ended.
      prop :time_end, DateTime

      # Workspaces - A set of named filesystem or data resource shareable by workflow tasks.
      prop :workspaces, Set[Workspace]

      # Runtime topology - A graph of the component runtime topology for task's instance.
      prop :runtime_topology, Set[Dependency]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      prop :properties, [Property]
    end
  end
end
