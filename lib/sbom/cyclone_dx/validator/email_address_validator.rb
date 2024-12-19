# frozen_string_literal: true

require_relative "base_validator"
require_relative("../../../email_address_extension")

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class EmailAddressValidator < BaseValidator
        def initialize(required: false)
          super(EmailAddress::Address, String, required: required)
        end

        def validate(value)
          rv = super
          return rv unless value.is_a?(EmailAddress::Address) || value.is_a?(String)

          begin
            to_validate = value.is_a?(EmailAddress::Address) ? value : EmailAddress::Address.new(value)
            return rv if to_validate.valid?
          rescue NoMethodError
            # Do nothing, all errors handled below
          end

          rv << "Invalid email address"
        end
      end
    end
  end
end
