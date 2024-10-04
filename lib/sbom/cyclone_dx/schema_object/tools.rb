# frozen_string_literal: true
# rbs_inline: enabled

# Tools - The tool(s) used to identify, confirm, or score the vulnerability.
module SBOM
  module CycloneDX
    Tools = SchemaObject.build("Tools") do
      # Components - A list of software and hardware components used as tools.
      prop :components, Set[Component]

      # Services - A list of services used as tools. This may include microservices, function-as-a-service, and other types of network or intra-process services.
      prop :services, Set[Service]
    end
  end
end
