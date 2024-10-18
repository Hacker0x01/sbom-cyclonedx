# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/step"

describe SBOM::CycloneDX::Step do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:step) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:step, :all_fields) }.not_to raise_error
  end
end
