# frozen_string_literal: true
# rbs_inline: enabled

# Task - Describes the inputs, sequence of steps and resources used to accomplish a task and its output.
module SBOM
  module Cyclonedx
    class Task < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the task elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
      attr_accessor :uid #: String

      # Name - The name of the resource instance.
      attr_accessor :name #: String

      # Description - A description of the resource instance.
      attr_accessor :description #: String

      # Resource references - References to component or service resources that are used to realize the resource instance.
      attr_accessor :resource_references #: Set[ResourceReferenceChoice]

      # Task types - Indicates the types of activities performed by the set of workflow tasks.
      attr_accessor :task_types #: [TaskType]

      # Trigger - The trigger that initiated the task.
      attr_accessor :trigger #: Trigger

      # Steps - The sequence of steps for the task.
      attr_accessor :steps #: Set[Step]

      # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
      # Example: "a `configuration` file which was declared as a local `component` or `externalReference`"
      attr_accessor :inputs #: Set[InputType]

      # Outputs - Represents resources and data output from a task at runtime by executor or task commands
      # Example: "a log file or metrics data produced by the task"
      attr_accessor :outputs #: Set[Output]

      # Time start - The date and time (timestamp) when the task started.
      attr_accessor :time_start #: DateTime

      # Time end - The date and time (timestamp) when the task ended.
      attr_accessor :time_end #: DateTime

      # Workspaces - A set of named filesystem or data resource shareable by workflow tasks.
      attr_accessor :workspaces #: Set[Workspace]

      # Runtime topology - A graph of the component runtime topology for task's instance.
      attr_accessor :runtime_topology #: Set[Dependency]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
