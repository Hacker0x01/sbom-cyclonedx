# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/resource_reference_choice"

describe SBOM::CycloneDX::ResourceReferenceChoice do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:resource_reference_choice) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:resource_reference_choice, :all_fields) }.not_to raise_error
  end
end
