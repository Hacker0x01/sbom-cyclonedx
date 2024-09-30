# frozen_string_literal: true
# rbs_inline: enabled

# Patch - Specifies an individual patch
module Sbom
  module Cyclonedx
    class Patch < SchemaObject
      # Patch Type - Specifies the purpose for the patch including the resolution of defects, security issues, or new behavior or functionality.
      attr_accessor :type #: PatchType

      # Diff - The patch file (or diff) that shows changes. Refer to [https://en.wikipedia.org/wiki/Diff](https://en.wikipedia.org/wiki/Diff)
      attr_accessor :diff #: Diff

      # Resolves - A collection of issues the patch resolves
      attr_accessor :resolves #: [Issue]
    end
  end
end
