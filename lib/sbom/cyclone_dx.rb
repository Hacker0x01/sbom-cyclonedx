# frozen_string_literal: true

require "email_address"
require_relative "cyclone_dx/email_address"
require_relative "cyclone_dx/enum"
require_relative "cyclone_dx/pattern"
require_relative "cyclone_dx/schema_object"
require_relative "cyclone_dx/type"
require_relative "cyclone_dx/validator"
require_relative "cyclone_dx/version"

module SBOM
  module CycloneDX
    class Error < StandardError; end
  end
end
