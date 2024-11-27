# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/component_data"

describe SBOM::CycloneDX::Record::ComponentData do
  it "can be initialized with minimum required attributes" do
    expect { build(:component_data) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:component_data, :all_fields) }.not_to raise_error
  end
end
