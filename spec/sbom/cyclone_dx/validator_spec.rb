# frozen_string_literal: true

require "spec_helper"
require "active_support/all"
require "sbom/cyclone_dx"
require "sbom/cyclone_dx/record"
require "sbom/cyclone_dx/validator"

describe SBOM::CycloneDX::Validator do
  describe "#for" do
    let(:type_args) do
      {
        SBOM::CycloneDX::Validator::ArrayValidator => [:array, items: :boolean],
        SBOM::CycloneDX::Validator::BooleanValidator => [:boolean, {}],
        SBOM::CycloneDX::Validator::DateTimeValidator => [:date_time, {}],
        SBOM::CycloneDX::Validator::EmailAddressValidator => [:email_address, {}],
        SBOM::CycloneDX::Validator::FloatValidator => [:float, {}],
        SBOM::CycloneDX::Validator::IntegerValidator => [:integer, {}],
        SBOM::CycloneDX::Validator::RecordValidator => [Class.new(SBOM::CycloneDX::Record::Base), {}],
        SBOM::CycloneDX::Validator::StringValidator => [:string, {}],
        SBOM::CycloneDX::Validator::UnionValidator => [:union, of: %i[string integer]],
        SBOM::CycloneDX::Validator::URIValidator => [:uri, {}]
      }
    end

    it "returns the correct validator instance for the given type" do
      type_args.each do |validator_class, (type, type_args)|
        validator = described_class.for(type, **type_args)
        expect(validator).to be_a(validator_class)
      end
    end

    it "raises an ArgumentError when an unsupported type is given", rbs_test: :skip do
      expect { described_class.for(:unsupported) }.to raise_error(ArgumentError, "Unsupported type: unsupported")
      expect { described_class.for(Set) }.to raise_error(ArgumentError, "Unsupported type: Set")
    end
  end
end
