# frozen_string_literal: true

require_relative "../schema_object"

# Anonymous class from DataGovernanceResponsibleParty
module SBOM
  module CycloneDX
    class DataGovernanceResponsibleParty < Struct.new(
      "DataGovernanceResponsibleParty",
      # Organization - The organization that is responsible for specific data governance role(s).
      :organization,
      # Individual - The individual that is responsible for specific data governance role(s).
      :contact,
      keyword_init: true
    )
      include SchemaObject

      def initialize(organization: nil, contact: nil)
        raise ArgumentError, "must specify either organization or contact" if organization.nil? && contact.nil?

        super
      end

      def valid?
        Validator.valid?(OrganizationalEntity, organization, required: contact.nil?) &&
          Validator.valid?(OrganizationalContact, contact, required: organization.nil?)
      end
    end
  end
end
