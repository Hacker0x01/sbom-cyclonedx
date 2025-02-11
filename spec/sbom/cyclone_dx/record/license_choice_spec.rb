# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/license_choice"

describe SBOM::CycloneDX::Record::LicenseChoice do
  describe SBOM::CycloneDX::Record::LicenseChoice::LicenseExpression do
    it "can be initialized with minimum required attributes" do
      expect { build(:license_expression) }.not_to raise_error
    end

    it "can be initialized with all attributes" do
      expect { build(:license_expression, :all_fields) }.not_to raise_error
    end
  end

  describe SBOM::CycloneDX::Record::LicenseChoice::WrappedLicense do
    it "can be initialized with minimum required attributes" do
      expect { build(:wrapped_license) }.not_to raise_error
    end

    it "can be initialized with all attributes" do
      expect { build(:wrapped_license, :all_fields) }.not_to raise_error
    end
  end
end
