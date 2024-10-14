# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Anonymous class from ComponentData
module SBOM
  module CycloneDX
    class ComponentData < Struct.new(
      "ComponentData",
      # BOM Reference - An optional identifier which can be used to reference the dataset elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Type of Data - The general theme or subject matter of the data being specified.
      :type,
      # Dataset Name - The name of the dataset.
      :name,
      # Data Contents - The contents or references to the contents of the data being described.
      :contents,
      # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
      :classification,
      # Sensitive Data - A description of any sensitive data in a dataset.
      :sensitive_data,
      :graphics,
      # Dataset Description - A description of the dataset. Can describe size of dataset, whether it's used for source code, training, testing, or validation, etc.
      :description,
      # Data Governance
      :governance,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def initialize( # rubocop:disable Metrics/ParameterLists
        type:,
        bom_ref: nil,
        name: nil,
        contents: nil,
        classification: nil,
        sensitive_data: nil,
        graphics: nil,
        description: nil,
        governance: nil
      )
        super
      end

      def valid? # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(String, type, enum: Enum::COMPONENT_DATA_TYPE, required: true) &&
          Validator.valid?(String, name) &&
          Validator.valid?(Content, contents) &&
          Validator.valid?(String, classification) &&
          Validator.valid?(Array, sensitive_data, items: String) &&
          Validator.valid?(GraphicsCollection, graphics) &&
          Validator.valid?(String, description) &&
          Validator.valid?(DataGovernance, governance)
      end

      class Content < Struct.new(
        # Data Attachment - An optional way to include textual or encoded data.
        :attachment,
        # Data URL - The URL to where the data can be retrieved.
        :url,
        # Configuration Properties - Provides the ability to document name-value parameters used for configuration.
        :properties,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(Attachment, attachment) &&
            Validator.valid?(URI, url) &&
            Validator.valid?(Array, properties, items: Property)
        end
      end
    end
  end
end
