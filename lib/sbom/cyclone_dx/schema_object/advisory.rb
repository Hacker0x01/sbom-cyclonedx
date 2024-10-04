# frozen_string_literal: true
# rbs_inline: enabled

# Advisory - Title and location where advisory information can be obtained. An advisory is a notification of a threat to a component, service, or system.
module SBOM
  module CycloneDX
    Advisory = SchemaObject.build("Advisory") do
      # Title - An optional name of the advisory.
      prop :title, String

      # URL - Location where the advisory can be obtained.
      prop :url, URI, required: true
    end
  end
end
