# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "data_governance"

module SBOM
  module CycloneDX
    module Record
      # Schema name: ServiceData
      class ServiceData < Base
        # Directional Flow - Specifies the flow direction of the data. Direction is relative to the service. Inbound flow states that data enters the service. Outbound flow states that data leaves the service. Bi-directional states that data flows both ways and unknown states that the direction is not known.
        prop :flow, :string, enum: Enum::DATA_FLOW_DIRECTION, required: true
        # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
        prop :classification, :string, required: true
        # Name - Name for the defined data
        # Example: "Credit card reporting"
        prop :name, :string
        # Description - Short description of the data content and usage
        # Example: "Credit card information being exchanged in between the web app and the database"
        prop :description, :string
        # Data Governance
        prop :governance, DataGovernance
        # Source - The URI, URL, or BOM-Link of the components or services the data came in from
        prop :source, :union, of: [:uri, [:string, pattern: Pattern::CDX_URN]], required: true
        # Destination - The URI, URL, or BOM-Link of the components or services the data is sent to
        prop :destination, :union, of: [:uri, [:string, pattern: Pattern::CDX_URN]], required: true
      end
    end
  end
end
