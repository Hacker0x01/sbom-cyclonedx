# frozen_string_literal: true
# rbs_inline: enabled

# Anonymous class from ComponentData
module SBOM
  module CycloneDX
    ComponentData = SchemaObject.build("ComponentData") do
      # BOM Reference - An optional identifier which can be used to reference the dataset elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

      # Type of Data - The general theme or subject matter of the data being specified.
      prop :type, String, enum: Enum::COMPONENT_DATA_TYPE, required: true

      # Dataset Name - The name of the dataset.
      prop :name, String

      # Data Contents - The contents or references to the contents of the data being described.
      prop :contents, Content

      # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
      prop :classification, String

      # Sensitive Data - A description of any sensitive data in a dataset.
      prop :sensitive_data, [String]

      prop :graphics, GraphicsCollection

      # Dataset Description - A description of the dataset. Can describe size of dataset, whether it's used for source code, training, testing, or validation, etc.
      prop :description, String

      # Data Governance
      prop :governance, DataGovernance

      Content = SchemaObject.build("Content") do
        # Data Attachment - An optional way to include textual or encoded data.
        prop :attachment, Attachment

        # Data URL - The URL to where the data can be retrieved.
        prop :url, URI

        # Configuration Properties - Provides the ability to document name-value parameters used for configuration.
        prop :properties, [Property]
      end
    end
  end
end
