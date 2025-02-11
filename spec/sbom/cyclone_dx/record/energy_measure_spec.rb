# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/energy_measure"

describe SBOM::CycloneDX::Record::EnergyMeasure do
  it "can be initialized with minimum required attributes" do
    expect { build(:energy_measure) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:energy_measure, :all_fields) }.not_to raise_error
  end
end
