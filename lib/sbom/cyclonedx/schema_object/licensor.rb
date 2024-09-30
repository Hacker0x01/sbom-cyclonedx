# frozen_string_literal: true
# rbs_inline: enabled

# Licensor - The individual or organization that grants a license to another individual or organization
module Sbom
  module Cyclonedx
    class Licensor < SchemaObject
      # Licensor (Organization) - The organization that granted the license
      attr_accessor :organization #: OrganizationalEntity

      # Licensor (Individual) - The individual, not associated with an organization, that granted the license
      attr_accessor :individual #: OrganizationalContact
    end
  end
end
