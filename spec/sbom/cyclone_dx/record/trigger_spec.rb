# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/trigger"

describe SBOM::CycloneDX::Record::Trigger do
  it "can be initialized with minimum required attributes" do
    expect { build(:trigger) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:trigger, :all_fields) }.not_to raise_error
  end
end
