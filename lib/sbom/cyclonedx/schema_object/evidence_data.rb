# frozen_string_literal: true
# rbs_inline: enabled

# CycloneDX Bill of Materials Standard
module SBOM
  module Cyclonedx
    class Root < SchemaObject
      # Data Name - The name of the data.
      attr_accessor :name #: String

      # Data Contents - The contents or references to the contents of the data being described.
      attr_accessor :contents #: Contents

      # Data Classification - The classification of the data.
      attr_accessor :classification #: DataClassification

      # Sensitive Data - A description of any sensitive data included.
      attr_accessor :sensitive_data #: [String]

      # Data Governance - Data governance information.
      attr_accessor :governance #: DataGovernance

      class Contents < SchemaObject
        # Data Attachment - An optional way to include textual or encoded data.
        attr_accessor :attachment #: Attachment

        # Data URL - The URL to where the data can be retrieved.
        attr_accessor :url #: URI
      end
    end
  end
end
