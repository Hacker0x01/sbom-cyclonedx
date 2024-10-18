# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/note"

describe SBOM::CycloneDX::Note do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:note) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:note, :all_fields) }.not_to raise_error
  end
end
