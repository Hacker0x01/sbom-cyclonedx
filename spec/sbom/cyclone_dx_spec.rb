# frozen_string_literal: true

RSpec.describe SBOM::CycloneDX do
  it "has a version number" do
    expect(SBOM::CycloneDX::VERSION).not_to be_nil
  end
end
