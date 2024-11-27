# frozen_string_literal: true

require_relative "base_validator"
require_relative("../email_address")

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class EmailAddressValidator < BaseValidator
        def valid?(value)
          return false unless super(value, SBOM::CycloneDX::EmailAddress, String)
          return value.valid? if value.is_a?(SBOM::CycloneDX::EmailAddress)

          begin
            SBOM::CycloneDX::EmailAddress.new(value).valid?
          rescue NoMethodError
            false
          end
        end
      end
    end
  end
end
