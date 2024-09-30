# frozen_string_literal: true
# rbs_inline: enabled

# Identifiable Action - Specifies an individual commit
module Sbom
  module Cyclonedx
    class IdentifiableAction < SchemaObject
      # Timestamp - The timestamp in which the action occurred
      attr_accessor :timestamp #: DateTime

      # Name - The name of the individual who performed the action
      attr_accessor :name #: String

      # E-mail - The email address of the individual who performed the action
      attr_accessor :email #: EmailAddress
    end
  end
end
