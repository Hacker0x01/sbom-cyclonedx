# frozen_string_literal: true

require "email_address"

module SBOM
  module CycloneDX
    # The email_address gem has a couple of undesired behaviors we need to work around:
    # - It checks the MX record of the domain, which is not necessary for our use-case
    # - as_json/to_json output a huge hash/object, but we just want the email address as a string
    class EmailAddress < ::EmailAddress::Address
      def initialize(email_address, config = {}, locale = "en")
        config[:dns_lookup] = :off
        config[:host_validation] = :syntax

        super
      end

      alias as_json to_s
      alias to_json to_s

      def self.valid?(email_address)
        new(email_address).valid?
      end
    end
  end
end
