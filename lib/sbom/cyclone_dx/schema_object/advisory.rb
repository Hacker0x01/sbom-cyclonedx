# frozen_string_literal: true

require "uri"
require_relative "../schema_object"

# Advisory - Title and location where advisory information can be obtained. An advisory is a notification of a threat to a component, service, or system.
module SBOM
  module CycloneDX
    class Advisory < Struct.new("Advisory", :title, :url, keyword_init: true)
      include SchemaObject

      def initialize(url:, title: nil)
        super
      end

      def valid?
        Validator.valid?(String, title) &&
          Validator.valid?(URI, url, required: true)
      end
    end
  end
end
