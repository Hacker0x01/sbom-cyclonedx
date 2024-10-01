# frozen_string_literal: true
# rbs_inline: enabled

# Reference
module SBOM
  module Cyclonedx
    class Reference < SchemaObject
      # ID - An identifier that uniquely identifies the vulnerability.
      # Examples: "CVE-2021-39182", "GHSA-35m5-8cvj-8783", "SNYK-PYTHON-ENROCRYPT-1912876"
      attr_accessor :id #: String

      validate :id, required: true

      # The source that published the vulnerability.
      attr_accessor :source #: VulnerabilitySource

      validate :source, required: true
    end
  end
end
