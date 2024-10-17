# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/energy_consumption"

describe SBOM::CycloneDX::EnergyConsumption do
  it "can be initialized with minimum required attributes" do
    expect { build(:energy_consumption) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:energy_consumption, :all_fields) }.not_to raise_error
  end
end
