# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/composition"

describe SBOM::CycloneDX::Record::Composition do
  it "can be initialized with minimum required attributes" do
    expect { build(:composition) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:composition, :all_fields) }.not_to raise_error
  end
end
