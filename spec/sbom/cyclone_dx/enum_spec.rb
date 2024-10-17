# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/enum"

describe SBOM::CycloneDX::Enum do
  let(:all_enums) do
    described_class.constants.filter_map do |constant|
      next unless constant.match?(/\A[A-Z_]+\Z/)

      described_class.const_get(constant)
    end
  end

  it "only has Array enums" do
    expect(all_enums.all?(Array)).to be true
  end

  it "has unique values per enum" do
    all_enums.each do |enum|
      expect(enum.uniq).to eq(enum)
    end
  end

  it "has the same type for all values in a given enum" do
    all_enums.each do |enum|
      expect(enum.all?(enum.first.class)).to be true
    end
  end
end
