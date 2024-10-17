# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/commit"

describe SBOM::CycloneDX::Commit do
  it "can be initialized with minimum required attributes" do
    expect { build(:commit) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:commit, :all_fields) }.not_to raise_error
  end
end
