# frozen_string_literal: true
# rbs_inline: enabled

# Event - Represents something that happened that may trigger a response.
module Sbom
  module Cyclonedx
    class Event < SchemaObject
      # Unique Identifier (UID) - The unique identifier of the event.
      attr_accessor :uid #: String

      # Description - A description of the event.
      attr_accessor :description #: String

      # Time Received - The date and time (timestamp) when the event was received.
      attr_accessor :time_received #: DateTime

      # Data - Encoding of the raw event data.
      attr_accessor :data #: Attachment

      # Source - References the component or service that was the source of the event
      attr_accessor :source #: ResourceReferenceChoice

      # Target - References the component or service that was the target of the event
      attr_accessor :target #: ResourceReferenceChoice

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
