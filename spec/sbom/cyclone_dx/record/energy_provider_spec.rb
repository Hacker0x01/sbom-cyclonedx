# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/energy_provider"

describe SBOM::CycloneDX::Record::EnergyProvider do
  it "can be initialized with minimum required attributes" do
    expect { build(:energy_provider) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:energy_provider, :all_fields) }.not_to raise_error
  end
end
