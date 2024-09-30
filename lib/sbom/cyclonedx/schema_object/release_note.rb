# frozen_string_literal: true
# rbs_inline: enabled

# Release notes
module Sbom
  module Cyclonedx
    class ReleaseNote < SchemaObject
      # Type - The software versioning type. It is recommended that the release type use one of 'major', 'minor', 'patch', 'pre-release', or 'internal'. Representing all possible software release types is not practical, so standardizing on the recommended values, whenever possible, is strongly encouraged.
      # * major = A major release may contain significant changes or may introduce breaking changes.
      # * minor = A minor release, also known as an update, may contain a smaller number of changes than major releases.
      # * patch = Patch releases are typically unplanned and may resolve defects or important security issues.
      # * pre-release = A pre-release may include alpha, beta, or release candidates and typically have limited support. They provide the ability to preview a release prior to its general availability.
      # * internal = Internal releases are not for public consumption and are intended to be used exclusively by the project or manufacturer that produced it.
      attr_accessor :type #: String

      # Title - The title of the release.
      attr_accessor :title #: String

      # Featured image - The URL to an image that may be prominently displayed with the release note.
      attr_accessor :featured_image #: URI

      # Social image - The URL to an image that may be used in messaging on social media platforms.
      attr_accessor :social_image #: URI

      # Description - A short description of the release.
      attr_accessor :description #: String

      # Timestamp - The date and time (timestamp) when the release note was created.
      attr_accessor :timestamp #: DateTime

      # Aliases - One or more alternate names the release may be referred to. This may include unofficial terms used by development and marketing teams (e.g. code names).
      attr_accessor :aliases #: [String]

      # Tags
      attr_accessor :tags #: Tag

      # Resolves - A collection of issues that have been resolved.
      attr_accessor :resolves #: [Issue]

      # Notes - Zero or more release notes containing the locale and content. Multiple note objects may be specified to support release notes in a wide variety of languages.
      attr_accessor :notes #: [Note]

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
