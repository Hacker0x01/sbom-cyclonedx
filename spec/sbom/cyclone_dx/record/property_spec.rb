# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/property"

describe SBOM::CycloneDX::Record::Property do
  it "can be initialized with minimum required attributes" do
    expect { build(:property) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:property, :all_fields) }.not_to raise_error
  end
end
