# frozen_string_literal: true

require_relative "../enum"
require_relative "base"
require_relative "diff"
require_relative "issue"

# Patch - Specifies an individual patch
module SBOM
  module CycloneDX
    module Record
      # Schema name: Patch
      class Patch < Base
        # Patch Type - Specifies the purpose for the patch including the resolution of defects, security issues, or new behavior or functionality.
        prop :type, :string, enum: Enum::PATCH_TYPE, required: true
        # Diff - The patch file (or diff) that shows changes. Refer to [https://en.wikipedia.org/wiki/Diff](https://en.wikipedia.org/wiki/Diff)
        prop :diff, Diff
        # Resolves - A collection of issues the patch resolves
        prop :resolves, :array, items: Issue
      end
    end
  end
end
