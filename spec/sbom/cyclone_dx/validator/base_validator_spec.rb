# frozen_string_literal: true

require "spec_helper"

# This is a simple type validator, with no options
describe SBOM::CycloneDX::Validator::BaseValidator do
  subject(:validator_klass) { Class.new(described_class) }

  describe "#initialize" do
    it "returns an error if not subclassed" do
      expect { described_class.new }.to raise_error(RuntimeError)
    end

    it "accepts optional class types" do
      expect { validator_klass.new }.not_to raise_error
      expect { validator_klass.new(Integer) }.not_to raise_error
      expect { validator_klass.new(String, Float) }.not_to raise_error
    end

    it "accepts optional :required" do
      expect(validator_klass.new).not_to be_required
      expect(validator_klass.new(required: true)).to be_required
    end
  end

  describe "#required?" do
    it "returns true when initialized with required: true" do
      expect(validator_klass.new(required: true).required?).to be true
    end

    it "returns false when intialized with required: false" do
      expect(validator_klass.new(required: false).required?).to be false
    end
  end

  describe "#valid?" do
    subject(:validator) { validator_klass.new }

    it "returns true when #validate returns no errors" do
      allow(validator).to receive(:validate).and_return([]) # rubocop:disable RSpec/SubjectStub
      expect(validator.valid?(1)).to be true
    end

    it "returns false when #validate returns errors" do
      allow(validator).to receive(:validate).and_return(["some error"]) # rubocop:disable RSpec/SubjectStub
      expect(validator.valid?(1)).to be false
    end
  end

  describe "#validate" do
    subject(:validator) { validator_klass.new(Integer, String) }

    it "returns an empty array when the arg is one of the specified types" do
      expect(validator.validate(1)).to eq []
      expect(validator.validate("a")).to eq []
    end

    it "returns an error when the arg is not one of the specified types" do
      expect(validator.validate(1.5)).to contain_exactly(an_instance_of(String))
      expect(validator.validate(%w[a b c])).to contain_exactly(an_instance_of(String))
    end

    it "returns an empty array when the arg is nil and required is false" do
      expect(validator_klass.new(Integer, required: false).validate(nil)).to eq []
    end

    it "returns an error when the arg is nil and required is true" do
      expect(validator_klass.new(Integer, required: true).validate(nil)).to contain_exactly(an_instance_of(String))
    end
  end
end
