# frozen_string_literal: true

require "spec_helper"

# This is a simple type validator, with no options
describe SBOM::CycloneDX::Validator::DateTimeValidator do
  subject(:validator) { described_class.new(required: true) }

  it "accepts DateTime instances" do
    expect(validator.validate(DateTime.current)).to be_empty
  end

  it "accepts Time instances" do
    expect(validator.validate(Time.now)).to be_empty
  end

  it "accepts strings in ISO 8601 format" do
    expect(validator.validate("2022-01-01T12:00:00Z")).to be_empty
  end

  it "rejects Date instances" do
    expect(validator.validate(Date.today)).not_to be_empty
  end

  it "rejects strings in other formats" do
    expect(validator.validate("6/15/2013, 5:32:17 PM")).not_to be_empty
  end
end
