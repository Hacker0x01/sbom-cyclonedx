# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/metadata"

describe SBOM::CycloneDX::Metadata do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:metadata) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:metadata, :all_fields) }.not_to raise_error
  end
end
