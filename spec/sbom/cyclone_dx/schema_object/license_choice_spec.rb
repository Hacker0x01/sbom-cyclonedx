# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/license_choice"

describe SBOM::CycloneDX::LicenseChoice do
  it "can be initialized with minimum required attributes" do
    expect { build(:license_choice) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:license_choice, :all_fields) }.not_to raise_error
  end
end
