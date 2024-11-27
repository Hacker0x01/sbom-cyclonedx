# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/service"

describe SBOM::CycloneDX::Record::Service do
  it "can be initialized with minimum required attributes" do
    expect { build(:service) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:service, :all_fields) }.not_to raise_error
  end
end
