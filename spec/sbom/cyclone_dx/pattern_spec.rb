# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/pattern"

describe SBOM::CycloneDX::Pattern do
  let(:all_patterns) do
    described_class.constants.filter_map do |constant|
      next unless constant.match?(/\A[A-Z_]+\Z/)

      described_class.const_get(constant)
    end
  end

  it "only has Regexp patterns" do
    expect(all_patterns.all?(Regexp)).to be true
  end
end
