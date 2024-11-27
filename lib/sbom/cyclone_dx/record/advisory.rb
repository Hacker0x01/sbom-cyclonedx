# frozen_string_literal: true

require "uri"
require_relative "base"

# Advisory - Title and location where advisory information can be obtained. An advisory is a notification of a threat to a component, service, or system.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Advisory
      class Advisory < Base
        prop :title, :string
        prop :url, :uri, required: true
      end
    end
  end
end
