# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/license"

describe SBOM::CycloneDX::Record::License do
  it "can be initialized with minimum required attributes" do
    expect { build(:license) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:license, :all_fields) }.not_to raise_error
  end
end
