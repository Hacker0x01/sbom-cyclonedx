# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/trigger"

describe SBOM::CycloneDX::Trigger do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:trigger) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:trigger, :all_fields) }.not_to raise_error
  end
end
