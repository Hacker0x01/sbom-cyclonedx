# frozen_string_literal: true

require_relative "base"

# Diff - The patch file (or diff) that shows changes. Refer to https://en.wikipedia.org/wiki/Diff
module SBOM
  module CycloneDX
    module Record
      # Schema name: Diff
      class Diff < Base
        # Diff text - Specifies the optional text of the diff
        prop :text, Attachment
        # URL - Specifies the URL to the diff
        prop :url, :uri
      end
    end
  end
end
