# frozen_string_literal: true

require_relative "base"
require_relative "component"
require_relative "service"

# Tools - The tool(s) used to identify, confirm, or score the vulnerability.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Tools
      class Tools < Base
        # Components - A list of software and hardware components used as tools.
        prop :components, :array, items: Component, unique: true
        # Services - A list of services used as tools. This may include microservices, function-as-a-service, and other types of network or intra-process services.
        prop :services, :array, items: Service, unique: true
      end
    end
  end
end
