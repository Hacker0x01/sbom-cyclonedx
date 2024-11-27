# frozen_string_literal: true

require_relative "base"
require_relative "organizational_entity"
require_relative "organizational_contact"

# Anonymous class from DataGovernanceResponsibleParty
module SBOM
  module CycloneDX
    module Record
      # Schema name: DataGovernanceResponsibleParty
      class DataGovernanceResponsibleParty < Base
        # Organization - The organization that is responsible for specific data governance role(s).
        prop :organization, OrganizationalEntity
        # Individual - The individual that is responsible for specific data governance role(s).
        prop :contact, OrganizationalContact

        validate :organization, :contact, presence: :any
      end
    end
  end
end
