# frozen_string_literal: true
# rbs_inline: enabled

# Purchaser - The individual or organization that purchased the license
module SBOM
  module Cyclonedx
    class Purchaser < SchemaObject
      # Purchaser (Organization) - The organization that purchased the license
      attr_accessor :organization #: OrganizationalEntity

      validate :organization, required: -> { individual.nil? }

      # Purchaser (Individual) - The individual, not associated with an organization, that purchased the license
      attr_accessor :individual #: OrganizationalContact

      validate :individual, required: -> { organization.nil? }
    end
  end
end
