# frozen_string_literal: true
# rbs_inline: enabled

# Credits - Individuals or organizations credited with the discovery of the vulnerability.
module Sbom
  module Cyclonedx
    class Credit < SchemaObject
      # Organizations - The organizations credited with vulnerability discovery.
      attr_accessor :organizations #: [OrganizationalEntity]

      # Individuals - The individuals, not associated with organizations, that are credited with vulnerability discovery.
      attr_accessor :individuals #: [OrganizationalContact]
    end
  end
end
