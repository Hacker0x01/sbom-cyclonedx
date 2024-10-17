# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/annotation"

describe SBOM::CycloneDX::Annotation do
  it "can be initialized with minimum required attributes" do
    expect { build(:annotation) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:annotation, :all_fields) }.not_to raise_error
  end
end
