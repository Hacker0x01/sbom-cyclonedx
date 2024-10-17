# frozen_string_literal: true

require_relative "../schema_object"
require_relative "data_governance_responsible_party"

# Data Governance - Data governance captures information regarding data ownership, stewardship, and custodianship, providing insights into the individuals or entities responsible for managing, overseeing, and safeguarding the data throughout its lifecycle.
module SBOM
  module CycloneDX
    class DataGovernance < Struct.new(
      "DataGovernance",
      # Data Custodians - Data custodians are responsible for the safe custody, transport, and storage of data.
      :custodians,
      # Data Stewards - Data stewards are responsible for data content, context, and associated business rules.
      :stewards,
      # Data Owners - Data owners are concerned with risk and appropriate access to data.
      :owners,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(Array, custodians, items: DataGovernanceResponsibleParty) &&
          Validator.valid?(Array, stewards, items: DataGovernanceResponsibleParty) &&
          Validator.valid?(Array, owners, items: DataGovernanceResponsibleParty)
      end
    end
  end
end
