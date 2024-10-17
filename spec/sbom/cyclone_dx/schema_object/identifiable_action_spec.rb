# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/identifiable_action"

describe SBOM::CycloneDX::IdentifiableAction do
  it "can be initialized with minimum required attributes" do
    expect { build(:identifiable_action) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:identifiable_action, :all_fields) }.not_to raise_error
  end
end
