# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object/crypto_properties"

describe SBOM::CycloneDX::CryptoProperties do
  it "can be initialized with minimum required attributes" do
    expect { build(:crypto_properties) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:crypto_properties, :all_fields) }.not_to raise_error
  end
end
