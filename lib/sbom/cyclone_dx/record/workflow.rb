# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "dependency"
require_relative "input"
require_relative "output"
require_relative "property"
require_relative "resource_reference_choice"
require_relative "step"
require_relative "task"
require_relative "trigger"
require_relative "workspace"

# Workflow - A specialized orchestration task.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Workflow
      class Workflow < Base
        # BOM Reference - An optional identifier which can be used to reference the workflow elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref", required: true
        # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
        prop :uid, :string, required: true
        # Name - The name of the resource instance.
        prop :name, :string
        # Description - A description of the resource instance.
        prop :description, :string
        # Resource references - References to component or service resources that are used to realize the resource instance.
        prop :resource_references, :array, items: ResourceReferenceChoice, unique: true
        # Tasks - The tasks that comprise the workflow.
        prop :tasks, :array, items: Task, unique: true
        # Task dependency graph - The graph of dependencies between tasks within the workflow.
        prop :task_dependencies, :array, items: Dependency, unique: true
        # Task types - Indicates the types of activities performed by the set of workflow tasks.
        prop :task_types, :array, items: [:string, enum: Enum::TASK_TYPE], required: true
        # Trigger - The trigger that initiated the task.
        prop :trigger, Trigger
        # Steps - The sequence of steps for the task.
        prop :steps, :array, items: Step, unique: true
        # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
        prop :inputs, :array, items: Input, unique: true
        # Outputs - Represents resources and data output from a task at runtime by executor or task commands
        prop :outputs, :array, items: Output, unique: true
        # Time start - The date and time (timestamp) when the task started.
        prop :time_start, :date_time
        # Time end - The date and time (timestamp) when the task ended.
        prop :time_end, :date_time
        # Workspaces - A set of named filesystem or data resource shareable by workflow tasks.
        prop :workspaces, :array, items: Workspace, unique: true
        # Runtime topology - A graph of the component runtime topology for workflow's instance.
        prop :runtime_topology, :array, items: Dependency, unique: true
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
