# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/graphics_collection"

describe SBOM::CycloneDX::Record::GraphicsCollection do
  it "can be initialized with minimum required attributes" do
    expect { build(:graphics_collection) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:graphics_collection, :all_fields) }.not_to raise_error
  end
end
