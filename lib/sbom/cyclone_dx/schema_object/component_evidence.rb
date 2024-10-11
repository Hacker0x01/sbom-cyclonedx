# frozen_string_literal: true

require_relative "component_identity_evidence"
require_relative "copyright"
require_relative "license_choice"
require_relative "../pattern"
require_relative "../schema_object"

# Evidence - Provides the ability to document evidence collected through various forms of extraction or analysis.
module SBOM
  module CycloneDX
    class ComponentEvidence < Struct.new(
      "ComponentEvidence",
      # Identity Evidence - Evidence that substantiates the identity of a component. The identity may be an object or an array of identity objects. Support for specifying identity as a single object was introduced in CycloneDX v1.5. Arrays were introduced in v1.6. It is recommended that all implementations use arrays, even if only one identity object is specified.
      :identity,
      # Occurrences - Evidence of individual instances of a component spread across multiple locations.
      :occurrences,
      # Call Stack - Evidence of the components use through the callstack.
      :callstack,
      # License Evidence
      :licenses,
      # Copyright Evidence - Copyright evidence captures intellectual property assertions, providing evidence of possible ownership and legal protection.
      :copyright,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(Array, identity, items: ComponentIdentityEvidence) &&
          Validator.valid?(Array, occurrences, items: Occurrence) &&
          Validator.valid?(Callstack, callstack) &&
          Validator.valid?(Array, copyright, items: Copyright) &&
          Validator.valid?(
            Array,
            licenses,
            items: [Union, klasses: [LicenseChoice::LicenseExpression, LicenseChoice::WrappedLicense]]
          )
      end

      class Callstack < Struct.new(
        "Callstack",
        # Frames - Within a call stack, a frame is a discrete unit that encapsulates an execution context, including local variables, parameters, and the return address. As function calls are made, frames are pushed onto the stack, forming an array-like structure that orchestrates the flow of program execution and manages the sequence of function invocations.
        :frames,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(Array, frames, items: Frame)
        end

        class Frame < Struct.new(
          "Frame",
          # Package - A package organizes modules into namespaces, providing a unique namespace for each type it contains.
          :package,
          # Module - A module or class that encloses functions/methods and other code.
          :module,
          # Function - A block of code designed to perform a particular task.
          :function,
          # Parameters - Optional arguments that are passed to the module or function.
          :parameters,
          # Line - The line number the code that is called resides on.
          :line,
          # Column - The column the code that is called resides.
          :column,
          # Full Filename - The full path and filename of the module.
          :full_filename,
          keyword_init: true
        )
          include SchemaObject

          def valid?
            Validator.valid?(String, package) &&
              Validator.valid?(String, self[:module], required: true, required: true) &&
              Validator.valid?(String, function) &&
              Validator.valid?(Array, parameters, items: String) &&
              Validator.valid?(Integer, line) &&
              Validator.valid?(Integer, column) &&
              Validator.valid?(String, full_filename)
          end
        end
      end

      class Occurrence < Struct.new(
        "Occurrence",
        # BOM Reference - An optional identifier which can be used to reference the occurrence elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        :bom_ref,
        # Location - The location or path to where the component was found.
        :location,
        # Line Number - The line number where the component was found.
        :line,
        # Offset - The offset where the component was found.
        :offset,
        # Symbol - The symbol name that was found associated with the component.
        :symbol,
        # Additional Context - Any additional context of the detected component (e.g. a code snippet).
        :additional_context,
        keyword_init: true
      )
        include SchemaObject

        json_name :bom_ref, "bom-ref"

        def initialize(location:, bom_ref: nil, line: nil, offset: nil, symbol: nil, additional_context: nil) # rubocop:disable Metrics/ParameterLists
          super
        end

        def valid?
          Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
            Validator.valid?(String, location, required: true, required: true) &&
            Validator.valid?(Integer, line, minimum: 0) &&
            Validator.valid?(Integer, offset, minimum: 0) &&
            Validator.valid?(String, symbol) &&
            Validator.valid?(String, additional_context)
        end
      end
    end
  end
end
