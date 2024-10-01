# frozen_string_literal: true
# rbs_inline: enabled

# Annotator - The organization, person, component, or service which created the textual content of the annotation.
module SBOM
  module Cyclonedx
    class Annotator < SchemaObject
      # The organization that created the annotation
      attr_accessor :organization #: OrganizationalEntity

      # The person that created the annotation
      attr_accessor :individual #: OrganizationalContact

      # The tool or component that created the annotation
      attr_accessor :component #: Component

      # The service that created the annotation
      attr_accessor :service #: Service
    end
  end
end
