# frozen_string_literal: true
# rbs_inline: enabled

# Licensee - The individual or organization for which a license was granted to
module SBOM
  module Cyclonedx
    class Licensee < SchemaObject
      # Licensee (Organization) - The organization that was granted the license
      attr_accessor :organization #: OrganizationalEntity

      # Licensee (Individual) - The individual, not associated with an organization, that was granted the license
      attr_accessor :individual #: OrganizationalContact
    end
  end
end
