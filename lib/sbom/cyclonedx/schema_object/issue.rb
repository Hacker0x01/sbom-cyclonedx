# frozen_string_literal: true
# rbs_inline: enabled

# Issue - An individual issue that has been resolved.
module SBOM
  module Cyclonedx
    class Issue < SchemaObject
      # Issue Type - Specifies the type of issue
      attr_accessor :type #: IssueType

      validate :type, required: true

      # Issue ID - The identifier of the issue assigned by the source of the issue
      attr_accessor :id #: String

      # Issue Name - The name of the issue
      attr_accessor :name #: String

      # Issue Description - A description of the issue
      attr_accessor :description #: String

      # Source - The source of the issue where it is documented
      attr_accessor :source #: Source

      # References - A collection of URL's for reference. Multiple URLs are allowed.
      attr_accessor :references #: [URI]
    end
  end
end
