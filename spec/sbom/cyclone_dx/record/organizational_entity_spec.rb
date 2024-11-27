# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/organizational_entity"

describe SBOM::CycloneDX::Record::OrganizationalEntity do
  it "can be initialized with minimum required attributes" do
    expect { build(:organizational_entity) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:organizational_entity, :all_fields) }.not_to raise_error
  end
end
