# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/data_governance_responsible_party"

describe SBOM::CycloneDX::Record::DataGovernanceResponsibleParty do
  it "can be initialized with minimum required attributes" do
    expect { build(:data_governance_responsible_party) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:data_governance_responsible_party, :all_fields) }.not_to raise_error
  end

  it "is valid with either organization or contact" do
    expect { build(:data_governance_responsible_party, :organization) }.not_to raise_error
    expect { build(:data_governance_responsible_party, :contact) }.not_to raise_error
  end
end
