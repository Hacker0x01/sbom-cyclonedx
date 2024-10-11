# frozen_string_literal: true

require "active_support/core_ext/string"
require_relative "cyclone_dx/version"

# TODO: the following should be implemented
# - Parsing errors should include JSON path

module SBOM
  module CycloneDX
    class Error < StandardError; end

    module Boolean
      def self.extended(_base)
        raise NotImplementedError, "This is an internal placeholder module and should not be extended"
      end

      def self.included(_base)
        raise NotImplementedError, "This is an internal placeholder module and should not be included"
      end
    end

    module Union
      def self.extended(_base)
        raise NotImplementedError, "This is an internal placeholder module and should not be extended"
      end

      def self.included(_base)
        raise NotImplementedError, "This is an internal placeholder module and should not be included"
      end
    end
  end
end
