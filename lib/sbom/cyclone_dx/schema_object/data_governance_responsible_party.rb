# frozen_string_literal: true
# rbs_inline: enabled

# Anonymous class from DataGovernanceResponsibleParty
module SBOM
  module CycloneDX
    DataGovernanceResponsibleParty = SchemaObject.build("DataGovernanceResponsibleParty") do
      # Organization - The organization that is responsible for specific data governance role(s).
      prop :organization, OrganizationalEntity, required: -> { contact.nil? }

      # Individual - The individual that is responsible for specific data governance role(s).
      prop :contact, OrganizationalContact, required: -> { organization.nil? }
    end
  end
end
