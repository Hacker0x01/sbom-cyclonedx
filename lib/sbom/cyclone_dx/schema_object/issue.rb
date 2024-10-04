# frozen_string_literal: true
# rbs_inline: enabled

# Issue - An individual issue that has been resolved.
module SBOM
  module CycloneDX
    Issue = SchemaObject.build("Issue") do
      # Issue Type - Specifies the type of issue
      prop :type, String, enum: Enum::ISSUE_TYPE, required: true

      # Issue ID - The identifier of the issue assigned by the source of the issue
      prop :id, String

      # Issue Name - The name of the issue
      prop :name, String

      # Issue Description - A description of the issue
      prop :description, String

      # Source - The source of the issue where it is documented
      prop :source, Source

      # References - A collection of URL's for reference. Multiple URLs are allowed.
      prop :references, [URI]

      Source = SchemaObject.build("Source") do
        # Name - The name of the source.
        # Examples: "National Vulnerability Database", "NVD", "Apache"
        prop :name, String

        # URL - The url of the issue documentation as provided by the source
        prop :url, URI
      end
    end
  end
end
