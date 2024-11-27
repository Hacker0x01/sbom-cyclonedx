# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/metadata"

describe SBOM::CycloneDX::Record::Metadata do
  it "can be initialized with minimum required attributes" do
    expect { build(:metadata) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:metadata, :all_fields) }.not_to raise_error
  end
end
