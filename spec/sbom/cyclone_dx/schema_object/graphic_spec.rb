# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/graphic"

describe SBOM::CycloneDX::Graphic do
  it "can be initialized with minimum required attributes" do
    expect { build(:graphic) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:graphic, :all_fields) }.not_to raise_error
  end
end
