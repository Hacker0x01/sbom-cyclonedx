# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Workflow - A specialized orchestration task.
module SBOM
  module CycloneDX
    class Workflow < Struct.new(
      "Workflow",
      # BOM Reference - An optional identifier which can be used to reference the workflow elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Unique Identifier (UID) - The unique identifier for the resource instance within its deployment context.
      :uid,
      # Name - The name of the resource instance.
      :name,
      # Description - A description of the resource instance.
      :description,
      # Resource references - References to component or service resources that are used to realize the resource instance.
      :resource_references,
      # Tasks - The tasks that comprise the workflow.
      :tasks,
      # Task dependency graph - The graph of dependencies between tasks within the workflow.
      :task_dependencies,
      # Task types - Indicates the types of activities performed by the set of workflow tasks.
      :task_types,
      # Trigger - The trigger that initiated the task.
      :trigger,
      # Steps - The sequence of steps for the task.
      :steps,
      # Inputs - Represents resources and data brought into a task at runtime by executor or task commands
      :inputs,
      # Outputs - Represents resources and data output from a task at runtime by executor or task commands
      :outputs,
      # Time start - The date and time (timestamp) when the task started.
      :time_start,
      # Time end - The date and time (timestamp) when the task ended.
      :time_end,
      # Workspaces - A set of named filesystem or data resource shareable by workflow tasks.
      :workspaces,
      # Runtime topology - A graph of the component runtime topology for workflow's instance.
      :runtime_topology,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def initialize( # rubocop:disable Metrics/ParameterLists
        bom_ref:,
        uid:,
        name: nil,
        description: nil,
        resource_references: nil,
        task_types: nil,
        tasks: nil,
        task_dependencies: nil,
        trigger: nil,
        steps: nil,
        inputs: nil,
        outputs: nil,
        time_start: nil,
        time_end: nil,
        workspaces: nil,
        runtime_topology: nil,
        properties: nil
      )
        super
      end

      def valid? # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK, required: true) &&
          Validator.valid?(String, uid, required: true) &&
          Validator.valid?(String, name) &&
          Validator.valid?(String, description) &&
          Validator.valid?(Array, resource_references, unique: true, items: ResourceReferenceChoice) &&
          Validator.valid?(Array, tasks, unique: true, items: Task) &&
          Validator.valid?(Array, task_dependencies, unique: true, items: Dependency) &&
          Validator.valid?(Array, task_types, items: [String, enum: Enum::TASK_TYPE], required: true) &&
          Validator.valid?(Trigger, trigger) &&
          Validator.valid?(Array, steps, unique: true, items: Step) &&
          Validator.valid?(Array, inputs, unique: true, items: Input) &&
          Validator.valid?(Array, outputs, unique: true, items: Output) &&
          Validator.valid?(DateTime, time_start) &&
          Validator.valid?(DateTime, time_end) &&
          Validator.valid?(Array, workspaces, unique: true, items: Workspace) &&
          Validator.valid?(Array, runtime_topology, unique: true, items: Dependency) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
