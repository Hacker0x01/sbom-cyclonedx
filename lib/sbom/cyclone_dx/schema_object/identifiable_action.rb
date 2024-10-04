# frozen_string_literal: true
# rbs_inline: enabled

# Identifiable Action - Specifies an individual commit
module SBOM
  module CycloneDX
    IdentifiableAction = SchemaObject.build("IdentifiableAction") do
      # Timestamp - The timestamp in which the action occurred
      prop :timestamp, DateTime

      # Name - The name of the individual who performed the action
      prop :name, String

      # E-mail - The email address of the individual who performed the action
      prop :email, EmailAddress
    end
  end
end
