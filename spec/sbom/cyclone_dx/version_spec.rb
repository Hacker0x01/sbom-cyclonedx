# frozen_string_literal: true

require "spec_helper"

describe SBOM::CycloneDX do # rubocop:disable RSpec/SpecFilePathFormat
  it "has a version number" do
    expect(described_class::VERSION).not_to be_nil
  end
end
