# frozen_string_literal: true
# rbs_inline: enabled

# Affect
module SBOM
  module Cyclonedx
    class Affect < SchemaObject
      # Reference - References a component or service by the objects bom-ref
      attr_accessor :ref #: RefLink | BOMLinkElement

      # Versions - Zero or more individual versions or range of versions.
      attr_accessor :versions #: [Version]
    end
  end
end
