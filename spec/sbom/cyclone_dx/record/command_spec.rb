# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/command"

describe SBOM::CycloneDX::Record::Command do
  it "can be initialized with minimum required attributes" do
    expect { build(:command) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:command, :all_fields) }.not_to raise_error
  end
end
