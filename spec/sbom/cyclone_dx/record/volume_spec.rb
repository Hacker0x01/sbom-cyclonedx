# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/volume"

describe SBOM::CycloneDX::Record::Volume do
  it "can be initialized with minimum required attributes" do
    expect { build(:volume) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:volume, :all_fields) }.not_to raise_error
  end
end
