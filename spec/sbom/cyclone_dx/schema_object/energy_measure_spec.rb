# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/energy_measure"

describe SBOM::CycloneDX::EnergyMeasure do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:energy_measure) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:energy_measure, :all_fields) }.not_to raise_error
  end
end
