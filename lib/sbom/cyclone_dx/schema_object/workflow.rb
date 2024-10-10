# frozen_string_literal: true
# rbs_inline: enabled

# Workflow - A specialized orchestration task.
module SBOM
  module CycloneDX
    Workflow = SchemaObject.build("Workflow") do
      # BOM Reference - An optional identifier which can be used to reference the workflow elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK, required: true

      # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
      prop :uid, String, required: true

      # Name - The name of the resource instance.
      prop :name, String

      # Description - A description of the resource instance.
      prop :description, String

      # Resource references - References to component or service resources that are used to realize the resource instance.
      prop :resource_references, Set[ResourceReferenceChoice]

      # Tasks - The tasks that comprise the workflow.
      prop :tasks, Set[Task]

      # Task dependency graph - The graph of dependencies between tasks within the workflow.
      prop :task_dependencies, Set[Dependency]

      # Task types - Indicates the types of activities performed by the set of workflow tasks.
      prop :task_types, [String], all: { enum: Enum::TASK_TYPE }, required: true

      # Trigger - The trigger that initiated the task.
      prop :trigger, Trigger

      # Steps - The sequence of steps for the task.
      prop :steps, Set[Step]

      # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
      prop :inputs, Set[Input]

      # Outputs - Represents resources and data output from a task at runtime by executor or task commands
      prop :outputs, Set[Output]

      # Time start - The date and time (timestamp) when the task started.
      prop :time_start, DateTime

      # Time end - The date and time (timestamp) when the task ended.
      prop :time_end, DateTime

      # Workspaces - A set of named filesystem or data resource shareable by workflow tasks.
      prop :workspaces, Set[Workspace]

      # Runtime topology - A graph of the component runtime topology for workflow's instance.
      prop :runtime_topology, Set[Dependency]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      prop :properties, [Property]
    end
  end
end
