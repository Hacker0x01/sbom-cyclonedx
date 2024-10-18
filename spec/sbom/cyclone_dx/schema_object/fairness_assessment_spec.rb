# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/fairness_assessment"

describe SBOM::CycloneDX::FairnessAssessment do
  it "can be initialized with minimum required attributes", skip: "factory updates" do
    expect { build(:fairness_assessment) }.not_to raise_error
  end

  it "can be initialized with all attributes", skip: "factory updates" do
    expect { build(:fairness_assessment, :all_fields) }.not_to raise_error
  end
end
