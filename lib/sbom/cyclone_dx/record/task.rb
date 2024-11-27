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
require_relative "trigger"
require_relative "workspace"

# Task - Describes the inputs, sequence of steps and resources used to accomplish a task and its output.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Task
      class Task < Base
        # BOM Reference - An optional identifier which can be used to reference the task elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref", required: true
        # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
        prop :uid, :string, required: true
        # Name - The name of the resource instance.
        prop :name, :string
        # Description - A description of the resource instance.
        prop :description, :string
        # Resource references - References to component or service resources that are used to realize the resource instance.
        prop :resource_references, :array, items: ResourceReferenceChoice
        # Task types - Indicates the types of activities performed by the set of workflow tasks.
        prop :task_types, :array, items: [:string, enum: Enum::TASK_TYPE]
        # Trigger - The trigger that initiated the task.
        prop :trigger, Trigger
        # Steps - The sequence of steps for the task.
        prop :steps, :array, items: Step
        # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
        # Example: "a `configuration` file which was declared as a local `component` or `externalReference`"
        prop :inputs, :array, items: Input
        # Outputs - Represents resources and data output from a task at runtime by executor or task commands
        # Example: "a log file or metrics data produced by the task"
        prop :outputs, :array, items: Output
        # Time start - The date and time (timestamp) when the task started.
        prop :time_start, :date_time
        # Time end - The date and time (timestamp) when the task ended.
        prop :time_end, :date_time
        # Workspaces - A set of named filesystem or data resource shareable by workflow tasks.
        prop :workspaces, :array, items: Workspace, unique: true
        # Runtime topology - A graph of the component runtime topology for task's instance.
        prop :runtime_topology, :array, items: Dependency, unique: true
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
