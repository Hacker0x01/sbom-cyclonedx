# frozen_string_literal: true

require "spec_helper"

# This is a simple type validator, with no options
describe SBOM::CycloneDX::Validator::IntegerValidator do
  subject(:validator) { described_class.new(required: true) }

  let(:value) { Faker::Number.number }

  it "accepts Integer objects" do
    expect(validator.validate(value)).to be_empty
  end

  it "rejects other number-like objects" do
    expect(validator.validate(value.to_c)).not_to be_empty
    expect(validator.validate(value.to_f)).not_to be_empty
    expect(validator.validate(value.to_r)).not_to be_empty
    expect(validator.validate(value.to_s)).not_to be_empty
  end

  context "with constraints" do
    let(:minimum) { Faker::Number.number }
    let(:maximum) { minimum + Faker::Number.positive.to_i }

    it "accepts values greater than or equal to a specified minimum" do
      validator = described_class.new(minimum: minimum, required: true)

      expect(validator.validate(minimum)).to be_empty
      expect(validator.validate(minimum + 1)).to be_empty
    end

    it "accepts values less than or equal to a specified maximum" do
      validator = described_class.new(maximum: maximum, required: true)

      expect(validator.validate(maximum)).to be_empty
      expect(validator.validate(maximum - 1)).to be_empty
    end

    it "accepts values within the range indicated by both minimum and maxiumum" do
      validator = described_class.new(minimum: minimum, maximum: maximum, required: true)

      expect(validator.validate(minimum)).to be_empty
      expect(validator.validate(maximum)).to be_empty
      expect(validator.validate((minimum + maximum) / 2)).to be_empty
    end

    it "rejects values less than the specified minimum" do
      validator = described_class.new(minimum: minimum, required: true)

      expect(validator.validate(minimum - 1)).not_to be_empty
    end

    it "rejects values greater than the specified maximum" do
      validator = described_class.new(maximum: maximum, required: true)

      expect(validator.validate(maximum + 1)).not_to be_empty
    end

    it "rejects values outside the range indicated by both minimum and maximum" do
      validator = described_class.new(minimum: minimum, maximum: maximum, required: true)

      expect(validator.validate(minimum - 1)).not_to be_empty
      expect(validator.validate(maximum + 1)).not_to be_empty
    end

    it "raises an error if maximum is less than minimum" do
      expect { described_class.new(minimum: maximum, maximum: minimum, required: true) }.to raise_error(ArgumentError)
    end
  end
end
