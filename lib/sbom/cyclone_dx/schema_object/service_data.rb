# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

module SBOM
  module CycloneDX
    class ServiceData < Struct.new(
      "ServiceData",
      # Directional Flow - Specifies the flow direction of the data. Direction is relative to the service. Inbound flow states that data enters the service. Outbound flow states that data leaves the service. Bi-directional states that data flows both ways and unknown states that the direction is not known.
      :flow,
      # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
      :classification,
      # Name - Name for the defined data
      # Example: "Credit card reporting"
      :name,
      # Description - Short description of the data content and usage
      # Example: "Credit card information being exchanged in between the web app and the database"
      :description,
      # Data Governance
      :governance,
      # Source - The URI, URL, or BOM-Link of the components or services the data came in from
      :source,
      # Destination - The URI, URL, or BOM-Link of the components or services the data is sent to
      :destination,
      keyword_init: true
    )
      include SchemaObject

      def initialize(
        flow:,
        classification:,
        source:,
        destination:,
        name: nil,
        description: nil,
        governance: nil
      )
        super
      end

      def valid?
        Validator.valid?(String, flow, enum: Enum::DATA_FLOW_DIRECTION, required: true) &&
          Validator.valid?(String, classification, required: true) &&
          Validator.valid?(String, name) &&
          Validator.valid?(String, description) &&
          Validator.valid?(DataGovernance, governance) &&
          Validator.valid?(
            SBOM::CycloneDX::Type::Union,
            source,
            klasses: [URI, String],
            pattern: Pattern::CDX_URN,
            required: true
          ) &&
          Validator.valid?(
            SBOM::CycloneDX::Type::Union,
            destination,
            klasses: [URI, String],
            pattern: Pattern::CDX_URN,
            required: true
          )
      end
    end
  end
end
