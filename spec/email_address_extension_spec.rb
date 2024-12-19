# frozen_string_literal: true

require "spec_helper"
require "email_address_extension"

describe EmailAddressExtension do
  let(:email_address_string) { Faker::Internet.email }
  let(:email_address) { EmailAddress.new(email_address_string) }

  it "disables dns lookup" do
    expect(email_address.host.dns_enabled?).to be false
    expect(email_address.host.config[:dns_lookup]).to eq(:off)
  end

  it "disables host validation" do
    expect(email_address.host.dns_enabled?).to be false
    expect(email_address.host.config[:host_validation]).to eq(:syntax)
  end

  it "aliases #as_json to #to_s" do
    expect(email_address.as_json).to eq(email_address_string)
  end

  it "aliases #to_json to #to_s" do
    expect(email_address.to_json).to eq(email_address_string)
  end
end
