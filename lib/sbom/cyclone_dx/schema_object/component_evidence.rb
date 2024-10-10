# frozen_string_literal: true
# rbs_inline: enabled

# Evidence - Provides the ability to document evidence collected through various forms of extraction or analysis.
module SBOM
  module CycloneDX
    ComponentEvidence = SchemaObject.build("ComponentEvidence") do
      # Identity Evidence - Evidence that substantiates the identity of a component. The identity may be an object or an array of identity objects. Support for specifying identity as a single object was introduced in CycloneDX v1.5. Arrays were introduced in v1.6. It is recommended that all implementations use arrays, even if only one identity object is specified.
      prop :identity, [ComponentIdentityEvidence]

      # Occurrences - Evidence of individual instances of a component spread across multiple locations.
      prop :occurrences, [Occurrence]

      # Call Stack - Evidence of the components use through the callstack.
      prop :callstack, Callstack

      # License Evidence
      prop :licenses, [LicenseChoice], validate: LICENSE_CHOICE_VALIDATOR

      # Copyright Evidence - Copyright evidence captures intellectual property assertions, providing evidence of possible ownership and legal protection.
      prop :copyright, [Copyright]

      Callstack = SchemaObject.build("Callstack") do
        # Frames - Within a call stack, a frame is a discrete unit that encapsulates an execution context, including local variables, parameters, and the return address. As function calls are made, frames are pushed onto the stack, forming an array-like structure that orchestrates the flow of program execution and manages the sequence of function invocations.
        prop :frames, [Frame]

        Frame = SchemaObject.build("Frame") do
          # Package - A package organizes modules into namespaces, providing a unique namespace for each type it contains.
          prop :package, String

          # Module - A module or class that encloses functions/methods and other code.
          prop :module, String, required: true

          # Function - A block of code designed to perform a particular task.
          prop :function, String

          # Parameters - Optional arguments that are passed to the module or function.
          prop :parameters, [String]

          # Line - The line number the code that is called resides on.
          prop :line, Integer

          # Column - The column the code that is called resides.
          prop :column, Integer

          # Full Filename - The full path and filename of the module.
          prop :full_filename, String
        end
      end

      Occurrence = SchemaObject.build("Occurrence") do
        # BOM Reference - An optional identifier which can be used to reference the occurrence elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

        # Location - The location or path to where the component was found.
        prop :location, String, required: true

        # Line Number - The line number where the component was found.
        prop :line, Integer, minimum: 0

        # Offset - The offset where the component was found.
        prop :offset, Integer, minimum: 0

        # Symbol - The symbol name that was found associated with the component.
        prop :symbol, String

        # Additional Context - Any additional context of the detected component (e.g. a code snippet).
        prop :additional_context, String
      end
    end
  end
end
