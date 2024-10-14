# frozen_string_literal: true

require_relative "../schema_object"

# Tools - The tool(s) used to identify, confirm, or score the vulnerability.
module SBOM
  module CycloneDX
    class Tools < Struct.new(
      "Tools",
      # Components - A list of software and hardware components used as tools.
      :components,
      # Services - A list of services used as tools. This may include microservices, function-as-a-service, and other types of network or intra-process services.
      :services,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(Array, components, unique: true, items: Component) &&
          Validator.valid?(Array, services, unique: true, items: Service)
      end
    end
  end
end
