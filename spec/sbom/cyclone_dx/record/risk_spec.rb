# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/risk"

describe SBOM::CycloneDX::Record::Risk do
  it "can be initialized with minimum required attributes" do
    expect { build(:risk) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:risk, :all_fields) }.not_to raise_error
  end
end
