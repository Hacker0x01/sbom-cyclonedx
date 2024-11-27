# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/rating"

describe SBOM::CycloneDX::Record::Rating do
  it "can be initialized with minimum required attributes" do
    expect { build(:rating) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:rating, :all_fields) }.not_to raise_error
  end
end
