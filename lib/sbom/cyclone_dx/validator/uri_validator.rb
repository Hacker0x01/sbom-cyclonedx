# frozen_string_literal: true

require "uri"
require_relative "base_validator"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class URIValidator < BaseValidator
        def valid?(value)
          return false unless super(value, URI::Generic, String)

          begin
            # Steep is, for some reason, looking at OpenURI's ::URI, and not ::URI from stdlib...
            uri_value = value.is_a?(URI::Generic) ? value : URI.parse(value)
          rescue NoMethodError, URI::Error
            return false
          end

          uri_value.scheme.present? && uri_value.host.present?
        end
      end
    end
  end
end
