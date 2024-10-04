# frozen_string_literal: true
# rbs_inline: enabled

# Patch - Specifies an individual patch
module SBOM
  module CycloneDX
    Patch = SchemaObject.build("Patch") do
      # Patch Type - Specifies the purpose for the patch including the resolution of defects, security issues, or new behavior or functionality.
      prop :type, String, enum: Enum::PATCH_TYPE, required: true

      # Diff - The patch file (or diff) that shows changes. Refer to [https://en.wikipedia.org/wiki/Diff](https://en.wikipedia.org/wiki/Diff)
      prop :diff, Diff

      # Resolves - A collection of issues the patch resolves
      prop :resolves, [Issue]
    end
  end
end
