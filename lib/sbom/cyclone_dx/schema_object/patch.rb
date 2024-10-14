# frozen_string_literal: true

require_relative "../enum"
require_relative "../schema_object"

# Patch - Specifies an individual patch
module SBOM
  module CycloneDX
    class Patch < Struct.new(
      "Patch",
      # Patch Type - Specifies the purpose for the patch including the resolution of defects, security issues, or new behavior or functionality.
      :type,
      # Diff - The patch file (or diff) that shows changes. Refer to [https://en.wikipedia.org/wiki/Diff](https://en.wikipedia.org/wiki/Diff)
      :diff,
      # Resolves - A collection of issues the patch resolves
      :resolves,
      keyword_init: true
    )
      include SchemaObject

      def initialize(type:, diff: nil, resolves: nil)
        super
      end

      def valid?
        Validator.valid?(String, type, enum: Enum::PATCH_TYPE, required: true) &&
          Validator.valid?(Diff, diff) &&
          Validator.valid?(Array, resolves, items: Issue)
      end
    end
  end
end
