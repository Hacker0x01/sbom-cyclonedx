# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/attachment"

describe SBOM::CycloneDX::Record::Attachment do
  it "can be initialized with minimum required attributes" do
    expect { build(:attachment) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:attachment, :all_fields) }.not_to raise_error
  end
end
