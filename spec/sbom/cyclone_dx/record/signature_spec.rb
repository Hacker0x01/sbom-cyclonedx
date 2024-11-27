# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/signature"

describe SBOM::CycloneDX::Record::Signature do
  describe SBOM::CycloneDX::Record::Signature::JSFSignature do
    it "can be initialized with minimum required attributes" do
      expect { build(:jsf_signature) }.not_to raise_error
    end

    it "can be initialized with all attributes" do
      expect { build(:jsf_signature, :all_fields) }.not_to raise_error
    end
  end

  describe SBOM::CycloneDX::Record::Signature::SignatureChain do
    it "can be initialized with minimum required attributes" do
      expect { build(:signature_chain) }.not_to raise_error
    end

    it "can be initialized with all attributes" do
      expect { build(:signature_chain, :all_fields) }.not_to raise_error
    end
  end
end
