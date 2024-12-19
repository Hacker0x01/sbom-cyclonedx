# frozen_string_literal: true

require "spec_helper"

# This is a simple type validator, with no options
describe SBOM::CycloneDX::Validator::URIValidator do
  subject(:validator) { described_class.new(required: true) }

  it "accepts URI instances" do
    expect(validator.validate(URI.parse(Faker::Internet.url))).to be_empty
  end

  it "accepts strings representing valid URIs" do
    expect(validator.validate(Faker::Internet.url)).to be_empty
  end

  it "rejects strings representing invalid URIs" do
    expect(validator.validate("bad.uri")).not_to be_empty
    expect(validator.validate("bad.com")).not_to be_empty
  end
end
