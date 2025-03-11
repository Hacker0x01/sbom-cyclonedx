# frozen_string_literal: true

require "uri"
require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class URIValidator < BaseValidator
        def initialize(required: false)
          super(::URI::Generic, String, required: required)
        end

        def validate(value)
          rv = super
          return rv unless value.is_a?(::URI::Generic) || value.is_a?(String)

          begin
            # Steep is, for some reason, looking at OpenURI's ::URI, and not ::URI from stdlib...
            uri_value = value.is_a?(URI::Generic) ? value : URI.parse(value)
            return rv if uri_value.scheme.present?
          rescue NoMethodError, URI::Error
            # Do nothing, all errors handled below
          end

          rv << "Invalid URI"
        end
      end
    end
  end
end
