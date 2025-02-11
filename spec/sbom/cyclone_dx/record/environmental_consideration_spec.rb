# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/environmental_consideration"

describe SBOM::CycloneDX::Record::EnvironmentalConsideration do
  it "can be initialized with minimum required attributes" do
    expect { build(:environmental_consideration) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:environmental_consideration, :all_fields) }.not_to raise_error
  end
end
