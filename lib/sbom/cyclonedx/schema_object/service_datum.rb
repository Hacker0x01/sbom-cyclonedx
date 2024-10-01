# frozen_string_literal: true
# rbs_inline: enabled

# Hash Objects
module SBOM
  module Cyclonedx
    class ServiceDatum < SchemaObject
      # Directional Flow - Specifies the flow direction of the data. Direction is relative to the service. Inbound flow states that data enters the service. Outbound flow states that data leaves the service. Bi-directional states that data flows both ways and unknown states that the direction is not known.
      attr_accessor :flow #: DataFlowDirection

      # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
      attr_accessor :classification #: String

      # Name - Name for the defined data
      # Example: "Credit card reporting"
      attr_accessor :name #: String

      # Description - Short description of the data content and usage
      # Example: "Credit card information being exchanged in between the web app and the database"
      attr_accessor :description #: String

      # Data Governance
      attr_accessor :governance #: DataGovernance

      # Source - The URI, URL, or BOM-Link of the components or services the data came in from
      attr_accessor :source #: [URI | BOMLinkElement]

      # Destination - The URI, URL, or BOM-Link of the components or services the data is sent to
      attr_accessor :destination #: [URI | BOMLinkElement]
    end
  end
end
