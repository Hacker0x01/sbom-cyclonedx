# frozen_string_literal: true
# rbs_inline: enabled

# Advisory - Title and location where advisory information can be obtained. An advisory is a notification of a threat to a component, service, or system.
module SBOM
  module Cyclonedx
    class Advisory < SchemaObject
      # Title - An optional name of the advisory.
      attr_accessor :title #: String

      # URL - Location where the advisory can be obtained.
      attr_accessor :url #: URI
    end
  end
end
