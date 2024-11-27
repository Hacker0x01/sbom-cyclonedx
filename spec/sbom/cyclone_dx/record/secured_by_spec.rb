# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/secured_by"

describe SBOM::CycloneDX::Record::SecuredBy do
  it "can be initialized with minimum required attributes" do
    expect { build(:secured_by) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:secured_by, :all_fields) }.not_to raise_error
  end
end
