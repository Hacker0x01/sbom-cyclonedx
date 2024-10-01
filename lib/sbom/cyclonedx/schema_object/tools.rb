# frozen_string_literal: true
# rbs_inline: enabled

# Tools - The tool(s) used to identify, confirm, or score the vulnerability.
module SBOM
  module Cyclonedx
    class Tools < SchemaObject
      # Components - A list of software and hardware components used as tools.
      attr_accessor :components #: Set[Component]

      # Services - A list of services used as tools. This may include microservices, function-as-a-service, and other types of network or intra-process services.
      attr_accessor :services #: Set[Service]
    end
  end
end
