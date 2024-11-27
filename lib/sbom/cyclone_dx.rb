# frozen_string_literal: true

require "email_address"
require_relative "cyclone_dx/email_address"
require_relative "cyclone_dx/enum"
require_relative "cyclone_dx/field"
require_relative "cyclone_dx/pattern"
require_relative "cyclone_dx/record"
require_relative "cyclone_dx/validator"
require_relative "cyclone_dx/version"

module SBOM
  module CycloneDX
    class Error < StandardError; end
  end
end
