# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/workspace"

describe SBOM::CycloneDX::Workspace do
  it "can be initialized with minimum required attributes" do
    expect { build(:workspace) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:workspace, :all_fields) }.not_to raise_error
  end
end
