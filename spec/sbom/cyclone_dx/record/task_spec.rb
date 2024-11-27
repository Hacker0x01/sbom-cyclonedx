# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/task"

describe SBOM::CycloneDX::Record::Task do
  it "can be initialized with minimum required attributes" do
    expect { build(:task) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:task, :all_fields) }.not_to raise_error
  end
end
