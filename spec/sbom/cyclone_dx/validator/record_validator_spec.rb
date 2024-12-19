# frozen_string_literal: true

require "spec_helper"

# This is a simple type validator, with no options
describe SBOM::CycloneDX::Validator::RecordValidator do
  subject(:validator) { described_class.new(type: value.class, required: true) }

  let(:value) { build(:note) }

  it "accepts records with the correct type" do
    expect(validator.validate(value)).to be_empty
  end

  it "rejects records with an incorrect type" do
    bad_value = build(:parameter)
    expect(validator.validate(bad_value)).not_to be_empty
  end

  it "validates simple fields" do
    value.locale = "en-US"
    expect(validator.validate(value)).to be_empty

    value.locale = "what is this nonsense"
    expect(validator.validate(value)).not_to be_empty
  end

  it "validates nested records" do
    value.text.content_type = "text/json"
    expect(validator.validate(value)).to be_empty

    value.text.content_type = "what is this nonsense"
    expect(validator.validate(value)).not_to be_empty
  end
end
