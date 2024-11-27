# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/external_reference"

describe SBOM::CycloneDX::Record::ExternalReference do
  it "can be initialized with minimum required attributes" do
    expect { build(:external_reference) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:external_reference, :all_fields) }.not_to raise_error
  end
end
