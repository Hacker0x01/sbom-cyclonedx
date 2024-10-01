# frozen_string_literal: true
# rbs_inline: enabled

# Licensor - The individual or organization that grants a license to another individual or organization
module SBOM
  module Cyclonedx
    class Licensor < SchemaObject
      # Licensor (Organization) - The organization that granted the license
      attr_accessor :organization #: OrganizationalEntity

      validate :organization, required: -> { individual.nil? }

      # Licensor (Individual) - The individual, not associated with an organization, that granted the license
      attr_accessor :individual #: OrganizationalContact

      validate :individual, required: -> { organization.nil? }
    end
  end
end
