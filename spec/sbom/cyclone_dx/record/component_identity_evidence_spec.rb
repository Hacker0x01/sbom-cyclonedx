# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/component_identity_evidence"

describe SBOM::CycloneDX::Record::ComponentIdentityEvidence do
  it "can be initialized with minimum required attributes" do
    expect { build(:component_identity_evidence) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:component_identity_evidence, :all_fields) }.not_to raise_error
  end
end
