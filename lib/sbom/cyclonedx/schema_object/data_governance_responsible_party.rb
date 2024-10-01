# frozen_string_literal: true
# rbs_inline: enabled

# Anonymous class from DataGovernanceResponsibleParty
module SBOM
  module Cyclonedx
    class DataGovernanceResponsibleParty < SchemaObject
      # Organization - The organization that is responsible for specific data governance role(s).
      attr_accessor :organization #: OrganizationalEntity

      # Individual - The individual that is responsible for specific data governance role(s).
      attr_accessor :contact #: OrganizationalContact
    end
  end
end
