# frozen_string_literal: true

require "spec_helper"

# This is a simple type validator, with no options
describe SBOM::CycloneDX::Validator::StringValidator do
  subject(:validator) { described_class.new(required: true) }

  let(:value) { Faker::Lorem.word }

  it "accepts String objects" do
    expect(validator.validate(value)).to be_empty
  end

  it "rejects other objects" do
    expect(validator.validate(0)).not_to be_empty
  end

  context "with enum" do
    subject(:validator) { described_class.new(enum: enum, required: true) }

    let(:enum) { Array.new(3) { Faker::Lorem.word } }

    it "accepts values in the enum" do
      enum.each do |value|
        expect(validator.validate(value)).to be_empty
      end
    end

    it "rejects values not in the enum" do
      expect(validator.validate(enum.join)).not_to be_empty
    end
  end

  context "with length constraints" do
    let(:min_length) { Faker::Number.number(digits: 2) }
    let(:max_length) { min_length + Faker::Number.number(digits: 2).to_i }

    it "accepts values with length greater than or equal to a specified min_length" do
      validator = described_class.new(min_length: min_length, required: true)

      expect(validator.validate("a" * min_length.to_i)).to be_empty
      expect(validator.validate("a" * (min_length.to_i + 1))).to be_empty
    end

    it "accepts values with length less than or equal to a specified max_length" do
      validator = described_class.new(max_length: max_length, required: true)

      expect(validator.validate("a" * max_length.to_i)).to be_empty
      expect(validator.validate("a" * (max_length.to_i - 1))).to be_empty
    end

    it "accepts values with length within the range indicated by both min_length and max_length" do
      validator = described_class.new(min_length: min_length, max_length: max_length, required: true)

      expect(validator.validate("a" * min_length.to_i)).to be_empty
      expect(validator.validate("a" * max_length.to_i)).to be_empty
      expect(validator.validate("a" * ((min_length.to_i + max_length.to_i) / 2))).to be_empty
    end

    it "rejects values with length less than the specified min_length" do
      validator = described_class.new(min_length: min_length, required: true)

      expect(validator.validate("a" * (min_length.to_i - 1))).not_to be_empty
    end

    it "rejects values with length greater than the specified max_length" do
      validator = described_class.new(max_length: max_length, required: true)

      expect(validator.validate("a" * (max_length.to_i + 1))).not_to be_empty
    end

    it "rejects values with length outside the range indicated by both min_length and max_length" do
      validator = described_class.new(min_length: min_length, max_length: max_length, required: true)

      expect(validator.validate("a" * (min_length.to_i - 1))).not_to be_empty
      expect(validator.validate("a" * (max_length.to_i + 1))).not_to be_empty
    end
  end

  context "with pattern" do
    subject(:validator) { described_class.new(pattern: pattern, required: true) }

    let(:pattern) { /\A[a-z]+\z/ }

    it "accepts values that match the pattern" do
      expect(validator.validate("abc")).to be_empty
    end

    it "rejects values that do not match the pattern" do
      expect(validator.validate("123")).not_to be_empty
    end
  end
end
