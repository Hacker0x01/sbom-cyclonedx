# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"

# Dependency - Defines the direct dependencies of a component, service, or the components provided/implemented by a given component. Components or services that do not have their own dependencies must be declared as empty elements within the graph. Components or services that are not represented in the dependency graph may have unknown dependencies. It is recommended that implementations assume this to be opaque and not an indicator of an object being dependency-free. It is recommended to leverage compositions to indicate unknown dependency graphs.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Dependency
      class Dependency < Base
        # Reference - References a component or service by its bom-ref attribute
        prop :ref, :string, pattern: Pattern::REF_LINK, required: true
        # Depends On - The bom-ref identifiers of the components or services that are dependencies of this dependency object.
        prop :depends_on, :array, items: [:string, pattern: Pattern::REF_LINK], unique: true
        # Provides - The bom-ref identifiers of the components or services that define a given specification or standard, which are provided or implemented by this dependency object. For example, a cryptographic library which implements a cryptographic algorithm. A component which implements another component does not imply that the implementation is in use.
        prop :provides, :array, items: [:string, pattern: Pattern::REF_LINK], unique: true
      end
    end
  end
end
