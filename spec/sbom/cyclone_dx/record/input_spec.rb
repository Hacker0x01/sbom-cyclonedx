# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/input"

describe SBOM::CycloneDX::Record::Input do
  it "can be initialized with minimum required attributes" do
    expect { build(:input) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:input, :all_fields) }.not_to raise_error
  end
end
