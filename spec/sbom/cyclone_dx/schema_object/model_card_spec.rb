# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/model_card"

describe SBOM::CycloneDX::ModelCard do
  it "can be initialized with minimum required attributes" do
    expect { build(:model_card) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:model_card, :all_fields) }.not_to raise_error
  end
end
