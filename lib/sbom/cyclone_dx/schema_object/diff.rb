# frozen_string_literal: true
# rbs_inline: enabled

# Diff - The patch file (or diff) that shows changes. Refer to https://en.wikipedia.org/wiki/Diff
module SBOM
  module CycloneDX
    Diff = SchemaObject.build("Diff") do
      # Diff text - Specifies the optional text of the diff
      prop :text, Attachment

      # URL - Specifies the URL to the diff
      prop :url, URI
    end
  end
end
