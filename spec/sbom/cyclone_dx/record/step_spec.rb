# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/step"

describe SBOM::CycloneDX::Record::Step do
  it "can be initialized with minimum required attributes" do
    expect { build(:step) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:step, :all_fields) }.not_to raise_error
  end
end
