# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/postal_address"

describe SBOM::CycloneDX::Record::PostalAddress do
  it "can be initialized with minimum required attributes" do
    expect { build(:postal_address) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:postal_address, :all_fields) }.not_to raise_error
  end
end
