# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/swid"

describe SBOM::CycloneDX::Record::SWID do
  it "can be initialized with minimum required attributes" do
    expect { build(:swid) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:swid, :all_fields) }.not_to raise_error
  end
end
