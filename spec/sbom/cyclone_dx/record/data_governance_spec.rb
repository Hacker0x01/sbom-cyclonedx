# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/data_governance"

describe SBOM::CycloneDX::Record::DataGovernance do
  it "can be initialized with minimum required attributes" do
    expect { build(:data_governance) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:data_governance, :all_fields) }.not_to raise_error
  end
end
