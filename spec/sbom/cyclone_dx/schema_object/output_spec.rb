# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/output"

describe SBOM::CycloneDX::Output do
  it "can be initialized with minimum required attributes" do
    expect { build(:output) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:output, :all_fields) }.not_to raise_error
  end
end
