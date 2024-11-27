# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/performance_metric"

describe SBOM::CycloneDX::Record::PerformanceMetric do
  it "can be initialized with minimum required attributes" do
    expect { build(:performance_metric) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:performance_metric, :all_fields) }.not_to raise_error
  end
end
