# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/dependency"

describe SBOM::CycloneDX::Record::Dependency do
  it "can be initialized with minimum required attributes" do
    expect { build(:dependency) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:dependency, :all_fields) }.not_to raise_error
  end
end
