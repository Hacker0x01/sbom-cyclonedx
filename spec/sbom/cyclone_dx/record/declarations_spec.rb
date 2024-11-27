# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/declarations"

describe SBOM::CycloneDX::Record::Declarations do
  it "can be initialized with minimum required attributes" do
    expect { build(:declarations) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:declarations, :all_fields) }.not_to raise_error
  end
end
