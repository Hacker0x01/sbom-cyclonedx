# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/hash_data"

describe SBOM::CycloneDX::HashData do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:hash_data) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:hash_data, :all_fields) }.not_to raise_error
  end
end
