# frozen_string_literal: true

require_relative "../schema_object"
require_relative "../email_address"

# Identifiable Action - Specifies an individual commit
module SBOM
  module CycloneDX
    class IdentifiableAction < Struct.new(
      "IdentifiableAction",
      # Timestamp - The timestamp in which the action occurred
      :timestamp,
      # Name - The name of the individual who performed the action
      :name,
      # E-mail - The email address of the individual who performed the action
      :email,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(DateTime, timestamp) &&
          Validator.valid?(String, name) &&
          Validator.valid?(SBOM::CycloneDX::EmailAddress, email)
      end
    end
  end
end
