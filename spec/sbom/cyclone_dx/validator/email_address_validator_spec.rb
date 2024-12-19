# frozen_string_literal: true

require "spec_helper"

# This is a simple type validator, with no options
describe SBOM::CycloneDX::Validator::EmailAddressValidator do
  subject(:validator) { described_class.new(required: true) }

  it "accepts EmailAddress instances" do
    expect(validator.validate(EmailAddress::Address.new(Faker::Internet.email))).to be_empty
  end

  it "accepts strings representing valid email addresses" do
    expect(validator.validate(Faker::Internet.email)).to be_empty
  end

  it "rejects strings representing invalid email addresses" do
    expect(validator.validate("bad@email")).not_to be_empty
    expect(validator.validate("bad.email")).not_to be_empty
    expect(validator.validate("bad@.com")).not_to be_empty
    expect(validator.validate("bad.com")).not_to be_empty
  end
end
