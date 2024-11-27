# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"
require_relative "component_identity_evidence"
require_relative "copyright"
require_relative "license_choice"

# Evidence - Provides the ability to document evidence collected through various forms of extraction or analysis.
module SBOM
  module CycloneDX
    module Record
      # Schema name: ComponentEvidence
      class ComponentEvidence < Base
        # Schema name: Callstack
        class Callstack < Base
          # Schema name: Frame
          class Frame < Base
            # Package - A package organizes modules into namespaces, providing a unique namespace for each type it contains.
            prop :package, :string
            # Module - A module or class that encloses functions/methods and other code.
            prop :source_module, :string, required: true, json_name: "module"
            # Function - A block of code designed to perform a particular task.
            prop :function, :string
            # Parameters - Optional arguments that are passed to the module or function.
            prop :parameters, :array, items: :string
            # Line - The line number the code that is called resides on.
            prop :line, :integer
            # Column - The column the code that is called resides.
            prop :column, :integer
            # Full Filename - The full path and filename of the module.
            prop :full_filename, :string
          end

          # Frames - Within a call stack, a frame is a discrete unit that encapsulates an execution context, including local variables, parameters, and the return address. As function calls are made, frames are pushed onto the stack, forming an array-like structure that orchestrates the flow of program execution and manages the sequence of function invocations.
          prop :frames, :array, items: Frame
        end

        # Schema name: Occurrence
        class Occurrence < Base
          # BOM Reference - An optional identifier which can be used to reference the occurrence elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
          prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
          # Location - The location or path to where the component was found.
          prop :location, :string, required: true
          # Line Number - The line number where the component was found.
          prop :line, :integer
          # Offset - The offset where the component was found.
          prop :offset, :integer
          # Symbol - The symbol name that was found associated with the component.
          prop :symbol, :string
          # Additional Context - Any additional context of the detected component (e.g. a code snippet).
          prop :additional_context, :string
        end

        # Identity Evidence - Evidence that substantiates the identity of a component. The identity may be an object or an array of identity objects. Support for specifying identity as a single object was introduced in CycloneDX v1.5. Arrays were introduced in v1.6. It is recommended that all implementations use arrays, even if only one identity object is specified.
        prop :identity, :array, items: ComponentIdentityEvidence
        # Occurrences - Evidence of individual instances of a component spread across multiple locations.
        prop :occurrences, :array, items: Occurrence
        # Call Stack - Evidence of the components use through the callstack.
        prop :callstack, Callstack
        # License Evidence
        prop :licenses, :array, items: [:union, of: LicenseChoice::UNION_TYPE]
        # Copyright Evidence - Copyright evidence captures intellectual property assertions, providing evidence of possible ownership and legal protection.
        prop :copyright, :array, items: Copyright
      end
    end
  end
end
