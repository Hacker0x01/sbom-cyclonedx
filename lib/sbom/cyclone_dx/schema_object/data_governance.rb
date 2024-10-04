# frozen_string_literal: true
# rbs_inline: enabled

# Data Governance - Data governance captures information regarding data ownership, stewardship, and custodianship, providing insights into the individuals or entities responsible for managing, overseeing, and safeguarding the data throughout its lifecycle.
module SBOM
  module CycloneDX
    DataGovernance = SchemaObject.build("DataGovernance") do
      # Data Custodians - Data custodians are responsible for the safe custody, transport, and storage of data.
      prop :custodians, [DataGovernanceResponsibleParty]

      # Data Stewards - Data stewards are responsible for data content, context, and associated business rules.
      prop :stewards, [DataGovernanceResponsibleParty]

      # Data Owners - Data owners are concerned with risk and appropriate access to data.
      prop :owners, [DataGovernanceResponsibleParty]
    end
  end
end
