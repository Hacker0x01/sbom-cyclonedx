# frozen_string_literal: true
# rbs_inline: enabled

# Annotator - The organization, person, component, or service which created the textual content of the annotation.
module SBOM
  module Cyclonedx
    class Annotator < SchemaObject
      # The organization that created the annotation
      attr_accessor :organization #: OrganizationalEntity

      validate :organization, required: -> { individual.nil? && component.nil? && service.nil? }

      # The person that created the annotation
      attr_accessor :individual #: OrganizationalContact

      validate :individual, required: -> { organization.nil? && component.nil? && service.nil? }

      # The tool or component that created the annotation
      attr_accessor :component #: Component

      validate :component, required: -> { organization.nil? && individual.nil? && service.nil? }

      # The service that created the annotation
      attr_accessor :service #: Service

      validate :service, required: -> { organization.nil? && individual.nil? && component.nil? }
    end
  end
end
