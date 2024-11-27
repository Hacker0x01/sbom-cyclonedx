# frozen_string_literal: true

require_relative "../enum"
require_relative "base"

# Issue - An individual issue that has been resolved.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Issue
      class Issue < Base
        # Schema name: Source
        class Source < Base
          # Name - The name of the source.
          # Examples: "National Vulnerability Database", "NVD", "Apache"
          prop :name, :string
          # URL - The url of the issue documentation as provided by the source
          prop :url, :uri
        end

        # Issue Type - Specifies the type of issue
        prop :type, :string, enum: Enum::ISSUE_TYPE, required: true
        # Issue ID - The identifier of the issue assigned by the source of the issue
        prop :id, :string
        # Issue Name - The name of the issue
        prop :name, :string
        # Issue Description - A description of the issue
        prop :description, :string
        # Source - The source of the issue where it is documented
        prop :source, Source
        # References - A collection of URL's for reference. Multiple URLs are allowed.
        prop :references, :array, items: :uri
      end
    end
  end
end
