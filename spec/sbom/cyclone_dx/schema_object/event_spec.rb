# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/event"

describe SBOM::CycloneDX::Event do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:event) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:event, :all_fields) }.not_to raise_error
  end
end
