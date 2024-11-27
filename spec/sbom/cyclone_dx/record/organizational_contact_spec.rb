# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/organizational_contact"

describe SBOM::CycloneDX::Record::OrganizationalContact do
  it "can be initialized with minimum required attributes" do
    expect { build(:organizational_contact) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:organizational_contact, :all_fields) }.not_to raise_error
  end
end
