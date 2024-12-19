# frozen_string_literal: true

require_relative "base"
require_relative "../../../email_address_extension"

# Identifiable Action - Specifies an individual commit
module SBOM
  module CycloneDX
    module Record
      # Schema name: IdentifiableAction
      class IdentifiableAction < Base
        # Timestamp - The timestamp in which the action occurred
        prop :timestamp, :date_time
        # Name - The name of the individual who performed the action
        prop :name, :string
        # E-mail - The email address of the individual who performed the action
        prop :email, :email_address
      end
    end
  end
end
