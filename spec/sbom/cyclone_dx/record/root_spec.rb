# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/root"

describe SBOM::CycloneDX::Record::Root do
  it "can be initialized with minimum required attributes" do
    expect { build(:root) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:root, :all_fields) }.not_to raise_error
  end
end
