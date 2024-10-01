# frozen_string_literal: true
# rbs_inline: enabled

# Evidence - Provides the ability to document evidence collected through various forms of extraction or analysis.
module SBOM
  module Cyclonedx
    class ComponentEvidence < SchemaObject
      # Identity Evidence - Evidence that substantiates the identity of a component. The identity may be an object or an array of identity objects. Support for specifying identity as a single object was introduced in CycloneDX v1.5. Arrays were introduced in v1.6. It is recommended that all implementations use arrays, even if only one identity object is specified.
      attr_accessor :identity #: [ComponentIdentityEvidence]

      # Occurrences - Evidence of individual instances of a component spread across multiple locations.
      attr_accessor :occurrences #: [Occurrence]

      # Call Stack - Evidence of the components use through the callstack.
      attr_accessor :callstack #: Callstack

      # License Evidence
      attr_accessor :licenses #: [[WrappedLicense] | [LicenseExpression]]

      validate :licenses, lambda { |value|
        value.nil? || value.all? { |v| v.all?(WrappedLicense) || (v.first.is_a?(LicenseExpression) && v.length == 1) }
      }

      # Copyright Evidence - Copyright evidence captures intellectual property assertions, providing evidence of possible ownership and legal protection.
      attr_accessor :copyright #: [Copyright]
    end
  end
end
