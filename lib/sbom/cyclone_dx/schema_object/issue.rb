# frozen_string_literal: true

require_relative "../enum"
require_relative "../schema_object"

# Issue - An individual issue that has been resolved.
module SBOM
  module CycloneDX
    class Issue < Struct.new(
      "Issue",
      # Issue Type - Specifies the type of issue
      :type,
      # Issue ID - The identifier of the issue assigned by the source of the issue
      :id,
      # Issue Name - The name of the issue
      :name,
      # Issue Description - A description of the issue
      :description,
      # Source - The source of the issue where it is documented
      :source,
      # References - A collection of URL's for reference. Multiple URLs are allowed.
      :references,
      keyword_init: true
    )
      include SchemaObject

      def initialize( # rubocop:disable Metrics/ParameterLists
        type:,
        id: nil,
        name: nil,
        description: nil,
        source: nil,
        references: nil
      )
        super
      end

      def valid?
        Validator.valid?(String, type, enum: Enum::ISSUE_TYPE, required: true) &&
          Validator.valid?(String, id) &&
          Validator.valid?(String, name) &&
          Validator.valid?(String, description) &&
          Validator.valid?(Source, source) &&
          Validator.valid?(Array, references, items: URI)
      end

      class Source < Struct.new(
        "Source",
        # Name - The name of the source.
        # Examples: "National Vulnerability Database", "NVD", "Apache"
        :name,
        # URL - The url of the issue documentation as provided by the source
        :url,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(String, name) &&
            Validator.valid?(URI, url)
        end
      end
    end
  end
end
