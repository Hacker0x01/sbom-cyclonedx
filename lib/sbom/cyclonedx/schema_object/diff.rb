# frozen_string_literal: true
# rbs_inline: enabled

# Diff - The patch file (or diff) that shows changes. Refer to https://en.wikipedia.org/wiki/Diff
module SBOM
  module Cyclonedx
    class Diff < SchemaObject
      # Diff text - Specifies the optional text of the diff
      attr_accessor :text #: Attachment

      # URL - Specifies the URL to the diff
      attr_accessor :url #: URI
    end
  end
end
