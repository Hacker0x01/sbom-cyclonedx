# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"

# Dependency - Defines the direct dependencies of a component, service, or the components provided/implemented by a given component. Components or services that do not have their own dependencies must be declared as empty elements within the graph. Components or services that are not represented in the dependency graph may have unknown dependencies. It is recommended that implementations assume this to be opaque and not an indicator of an object being dependency-free. It is recommended to leverage compositions to indicate unknown dependency graphs.
module SBOM
  module CycloneDX
    class Dependency < Struct.new(
      "Dependency",
      # Reference - References a component or service by its bom-ref attribute
      :ref,
      # Depends On - The bom-ref identifiers of the components or services that are dependencies of this dependency object.
      :depends_on,
      # Provides - The bom-ref identifiers of the components or services that define a given specification or standard, which are provided or implemented by this dependency object. For example, a cryptographic library which implements a cryptographic algorithm. A component which implements another component does not imply that the implementation is in use.
      :provides,
      keyword_init: true
    )
      include SchemaObject

      def initialize(ref:, depends_on: nil, provides: nil)
        super
      end

      def valid?
        Validator.valid?(String, ref, pattern: Pattern::REF_LINK, required: true) &&
          Validator.valid?(Array, depends_on, unique: true, items: [String, pattern: Pattern::REF_LINK]) &&
          Validator.valid?(Array, provides, unique: true, items: [String, pattern: Pattern::REF_LINK])
      end
    end
  end
end
