# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "attachment"
require_relative "graphics_collection"
require_relative "data_governance"
require_relative "property"

# Anonymous class from ComponentData
module SBOM
  module CycloneDX
    module Record
      # Schema name: ComponentData
      class ComponentData < Base
        class Content < Base
          # Data Attachment - An optional way to include textual or encoded data.
          prop :attachment, Attachment
          # Data URL - The URL to where the data can be retrieved.
          prop :url, :uri
          # Configuration Properties - Provides the ability to document name-value parameters used for configuration.
          prop :properties, :array, items: Property
        end

        # BOM Reference - An optional identifier which can be used to reference the dataset elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Type of Data - The general theme or subject matter of the data being specified.
        prop :type, :string, enum: Enum::COMPONENT_DATA_TYPE, required: true
        # Dataset Name - The name of the dataset.
        prop :name, :string
        # Data Contents - The contents or references to the contents of the data being described.
        prop :contents, Content
        # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
        prop :classification, :string
        # Sensitive Data - A description of any sensitive data in a dataset.
        prop :sensitive_data, :array, items: :string
        prop :graphics, GraphicsCollection
        # Dataset Description - A description of the dataset. Can describe size of dataset, whether it's used for source code, training, testing, or validation, etc.
        prop :description, :string
        # Data Governance
        prop :governance, DataGovernance
      end
    end
  end
end
