# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/issue"

describe SBOM::CycloneDX::Record::Issue do
  it "can be initialized with minimum required attributes" do
    expect { build(:issue) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:issue, :all_fields) }.not_to raise_error
  end
end
