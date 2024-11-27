# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/diff"

describe SBOM::CycloneDX::Record::Diff do
  it "can be initialized with minimum required attributes" do
    expect { build(:diff) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:diff, :all_fields) }.not_to raise_error
  end
end
