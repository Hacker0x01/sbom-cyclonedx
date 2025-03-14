# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/advisory"

describe SBOM::CycloneDX::Record::Advisory do
  it "can be initialized with minimum required attributes" do
    expect { build(:advisory) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:advisory, :all_fields) }.not_to raise_error
  end
end
