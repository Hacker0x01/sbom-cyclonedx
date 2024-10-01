# frozen_string_literal: true
# rbs_inline: enabled

# Anonymous class from ComponentData
module SBOM
  module Cyclonedx
    class ComponentData < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the dataset elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Type of Data - The general theme or subject matter of the data being specified.
      attr_accessor :type #: ComponentDataType

      validate :type, required: true

      # Dataset Name - The name of the dataset.
      attr_accessor :name #: String

      # Data Contents - The contents or references to the contents of the data being described.
      attr_accessor :contents #: Content

      # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
      attr_accessor :classification #: String

      # Sensitive Data - A description of any sensitive data in a dataset.
      attr_accessor :sensitive_data #: [String]

      attr_accessor :graphics #: GraphicsCollection

      # Dataset Description - A description of the dataset. Can describe size of dataset, whether it's used for source code, training, testing, or validation, etc.
      attr_accessor :description #: String

      # Data Governance
      attr_accessor :governance #: DataGovernance
    end
  end
end
