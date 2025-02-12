# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/record/annotation"

describe SBOM::CycloneDX::Record::Annotation do
  it "can be initialized with minimum required attributes" do
    expect { build(:annotation) }.not_to raise_error
  end

  it "can be initialized with all attributes" do
    expect { build(:annotation, :all_fields) }.not_to raise_error
  end

  describe SBOM::CycloneDX::Record::Annotation::Annotator do
    it "can be initialized with minimum required attributes" do
      expect { build(:annotator) }.not_to raise_error
    end

    it "can be initialized with all attributes" do
      expect { build(:annotator, :all_fields) }.not_to raise_error
    end

    it "is valid with organization, contact, component, or service" do
      expect { build(:annotator, :organization) }.not_to raise_error
      expect { build(:annotator, :contact) }.not_to raise_error
      expect { build(:annotator, :component) }.not_to raise_error
      expect { build(:annotator, :service) }.not_to raise_error
    end
  end
end
