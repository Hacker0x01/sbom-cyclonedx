# frozen_string_literal: true

require_relative "base"
require_relative "data_governance_responsible_party"

# Data Governance - Data governance captures information regarding data ownership, stewardship, and custodianship, providing insights into the individuals or entities responsible for managing, overseeing, and safeguarding the data throughout its lifecycle.
module SBOM
  module CycloneDX
    module Record
      # Schema name: DataGovernance
      class DataGovernance < Base
        # Data Custodians - Data custodians are responsible for the safe custody, transport, and storage of data.
        prop :custodians, :array, items: DataGovernanceResponsibleParty
        # Data Stewards - Data stewards are responsible for data content, context, and associated business rules.
        prop :stewards, :array, items: DataGovernanceResponsibleParty
        # Data Owners - Data owners are concerned with risk and appropriate access to data.
        prop :owners, :array, items: DataGovernanceResponsibleParty
      end
    end
  end
end
