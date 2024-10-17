# frozen_string_literal: true

require_relative "../schema_object"

# Copyright - A copyright notice informing users of the underlying claims to copyright ownership in a published work.
module SBOM
  module CycloneDX
    class Copyright < Struct.new(
      "Copyright",
      # Copyright Text - The textual content of the copyright.
      :text,
      keyword_init: true
    )
      include SchemaObject

      def initialize(text:) # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def valid?
        Validator.valid?(String, text, required: true)
      end
    end
  end
end
