# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/event"

describe SBOM::CycloneDX::Record::Event do
  it "can be initialized with minimum required attributes" do
    expect { build(:event) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:event, :all_fields) }.not_to raise_error
  end
end
