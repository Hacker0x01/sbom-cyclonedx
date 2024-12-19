# frozen_string_literal: true

require "email_address"

module EmailAddressExtension
  # The email_address gem has a couple of undesired behaviors we need to work around:
  # - It checks the MX record of the domain, which is not necessary for our use-case
  # - as_json/to_json output a huge hash/object, but we just want the email address as a string
  def initialize(email_address, config = {}, locale = "en")
    config[:dns_lookup] = :off
    config[:host_validation] = :syntax

    super
  end

  # Using alias_method doesn't really work here, so we'll just override the methods
  def as_json(*_opts)
    to_s
  end

  def to_json(*_opts)
    to_s
  end
end

EmailAddress::Address.prepend(EmailAddressExtension)
