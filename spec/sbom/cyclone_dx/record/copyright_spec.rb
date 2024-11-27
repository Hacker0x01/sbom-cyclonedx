# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/copyright"

describe SBOM::CycloneDX::Record::Copyright do
  it "can be initialized with minimum required attributes" do
    expect { build(:copyright) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:copyright, :all_fields) }.not_to raise_error
  end
end
