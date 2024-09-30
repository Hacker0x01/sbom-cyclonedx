# frozen_string_literal: true
# rbs_inline: enabled

# Data Contents - The contents or references to the contents of the data being described.
module Sbom
  module Cyclonedx
    class Content < SchemaObject
      # Data Attachment - An optional way to include textual or encoded data.
      attr_accessor :attachment #: Attachment

      # Data URL - The URL to where the data can be retrieved.
      attr_accessor :url #: URI

      # Configuration Properties - Provides the ability to document name-value parameters used for configuration.
      attr_accessor :properties #: [Property]
    end
  end
end
