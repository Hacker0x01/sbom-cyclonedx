# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/note"

describe SBOM::CycloneDX::Record::Note do
  it "can be initialized with minimum required attributes" do
    expect { build(:note) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:note, :all_fields) }.not_to raise_error
  end
end
