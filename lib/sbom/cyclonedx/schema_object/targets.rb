# frozen_string_literal: true
# rbs_inline: enabled

# Target - Target which a clame may be made against.
module SBOM
  module Cyclonedx
    class Target < SchemaObject
      # Organizations - The list of organizations which claims are made against.
      attr_accessor :organizations #: [OrganizationalEntity]

      # Components - The list of components which claims are made against.
      attr_accessor :components #: [Component]

      # Services - The list of services which claims are made against.
      attr_accessor :services #: [Service]
    end
  end
end
