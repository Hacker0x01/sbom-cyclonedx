# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/cipher_suite"

describe SBOM::CycloneDX::Record::CipherSuite do
  it "can be initialized with minimum required attributes" do
    expect { build(:cipher_suite) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:cipher_suite, :all_fields) }.not_to raise_error
  end
end
