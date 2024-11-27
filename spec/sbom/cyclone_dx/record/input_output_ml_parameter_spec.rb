# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/input_output_ml_parameter"

describe SBOM::CycloneDX::Record::InputOutputMLParameter do
  it "can be initialized with minimum required attributes" do
    expect { build(:input_output_ml_parameter) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:input_output_ml_parameter, :all_fields) }.not_to raise_error
  end
end
