# frozen_string_literal: true
# rbs_inline: enabled

module SBOM
  module CycloneDX
    ServiceData = SchemaObject.build("ServiceData") do
      # Directional Flow - Specifies the flow direction of the data. Direction is relative to the service. Inbound flow states that data enters the service. Outbound flow states that data leaves the service. Bi-directional states that data flows both ways and unknown states that the direction is not known.
      prop :flow, String, enum: Enum::DATA_FLOW_DIRECTION, required: true

      # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
      prop :classification, String, required: true

      # Name - Name for the defined data
      # Example: "Credit card reporting"
      prop :name, String

      # Description - Short description of the data content and usage
      # Example: "Credit card information being exchanged in between the web app and the database"
      prop :description, String

      # Data Governance
      prop :governance, DataGovernance

      # Source - The URI, URL, or BOM-Link of the components or services the data came in from
      prop :source,
           one_of: [URI, String],
           required: true,
           pattern: ->(value) { (value.is_a?(String) && Pattern::BOM_LINK) || nil }

      # Destination - The URI, URL, or BOM-Link of the components or services the data is sent to
      prop :destination,
           one_of: [URI, String],
           required: true,
           pattern: ->(value) { (value.is_a?(String) && Pattern::BOM_LINK) || nil }
    end
  end
end
