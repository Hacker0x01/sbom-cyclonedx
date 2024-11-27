# frozen_string_literal: true

require_relative "base"
require_relative "../validator/email_address_validator"

module SBOM
  module CycloneDX
    module Field
      class EmailAddress < Base
        def initialize(name:, required: false, const: NOT_SET, default: NOT_SET, json_name: nil)
          super(
            type: :email_address,
            name: name,
            validator: SBOM::CycloneDX::Validator::EmailAddressValidator.new(required: required),
            required: required,
            const: const,
            default: default,
            json_name: json_name
          )
        end
      end
    end
  end
end
