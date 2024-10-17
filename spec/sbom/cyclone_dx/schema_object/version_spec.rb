# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/version"

describe SBOM::CycloneDX::Version do
  it "can be initialized with minimum required attributes" do
    expect { build(:version) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:version, :all_fields) }.not_to raise_error
  end
end
