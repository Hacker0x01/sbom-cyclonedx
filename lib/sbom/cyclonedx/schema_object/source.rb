# frozen_string_literal: true
# rbs_inline: enabled

# Source - The source of the issue where it is documented
module SBOM
  module Cyclonedx
    class Source < SchemaObject
      # Name - The name of the source.
      # Examples: "National Vulnerability Database", "NVD", "Apache"
      attr_accessor :name #: String

      # URL - The url of the issue documentation as provided by the source
      attr_accessor :url #: URI
    end
  end
end
