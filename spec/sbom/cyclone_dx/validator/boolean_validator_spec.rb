# frozen_string_literal: true

require "spec_helper"

# This is a simple type validator, with no options
describe SBOM::CycloneDX::Validator::BooleanValidator do
  subject(:validator) { described_class.new(required: true) }

  it "accepts true" do
    expect(validator.validate(true)).to be_empty
  end

  it "accepts false" do
    expect(validator.validate(false)).to be_empty
  end

  it "rejects truthy values" do
    expect(validator.validate(1)).not_to be_empty
    expect(validator.validate("true")).not_to be_empty
  end

  it "rejects falsey values" do
    expect(validator.validate(0)).not_to be_empty
    expect(validator.validate(nil)).not_to be_empty
  end
end
