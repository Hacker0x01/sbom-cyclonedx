# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/component_data"

describe SBOM::CycloneDX::ComponentData do
  it "can be initialized with minimum required attributes" do
    expect { build(:component_data) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:component_data, :all_fields) }.not_to raise_error
  end
end
