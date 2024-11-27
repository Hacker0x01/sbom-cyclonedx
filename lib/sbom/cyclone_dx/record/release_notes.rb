# frozen_string_literal: true

require_relative "base"
require_relative "issue"
require_relative "note"
require_relative "property"

# Release notes
module SBOM
  module CycloneDX
    module Record
      # Schema name: ReleaseNotes
      class ReleaseNotes < Base
        # Type - The software versioning type. It is recommended that the release type use one of 'major', 'minor', 'patch', 'pre-release', or 'internal'. Representing all possible software release types is not practical, so standardizing on the recommended values, whenever possible, is strongly encouraged.
        # * major = A major release may contain significant changes or may introduce breaking changes.
        # * minor = A minor release, also known as an update, may contain a smaller number of changes than major releases.
        # * patch = Patch releases are typically unplanned and may resolve defects or important security issues.
        # * pre-release = A pre-release may include alpha, beta, or release candidates and typically have limited support. They provide the ability to preview a release prior to its general availability.
        # * internal = Internal releases are not for public consumption and are intended to be used exclusively by the project or manufacturer that produced it.
        prop :type, :string, required: true
        # Title - The title of the release.
        prop :title, :string
        # Featured image - The URL to an image that may be prominently displayed with the release note.
        prop :featured_image, :uri
        # Social image - The URL to an image that may be used in messaging on social media platforms.
        prop :social_image, :uri
        # Description - A short description of the release.
        prop :description, :string
        # Timestamp - The date and time (timestamp) when the release note was created.
        prop :timestamp, :date_time
        # Aliases - One or more alternate names the release may be referred to. This may include unofficial terms used by development and marketing teams (e.g. code names).
        prop :aliases, :array, items: :string
        # Tags
        prop :tags, :array, items: :string
        # Resolves - A collection of issues that have been resolved.
        prop :resolves, :array, items: Issue
        # Notes - Zero or more release notes containing the locale and content. Multiple note objects may be specified to support release notes in a wide variety of languages.
        prop :notes, :array, items: Note
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
