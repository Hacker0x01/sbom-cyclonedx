# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/hash_data"

describe SBOM::CycloneDX::Record::HashData do
  it "can be initialized with minimum required attributes" do
    expect { build(:hash_data) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:hash_data, :all_fields) }.not_to raise_error
  end
end
