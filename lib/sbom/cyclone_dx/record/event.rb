# frozen_string_literal: true

require_relative "base"
require_relative "attachment"
require_relative "property"
require_relative "resource_reference_choice"

# Event - Represents something that happened that may trigger a response.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Event
      class Event < Base
        # Unique Identifier (UID) - The unique identifier of the event.
        prop :uid, :string
        # Description - A description of the event.
        prop :description, :string
        # Time Received - The date and time (timestamp) when the event was received.
        prop :time_received, :date_time
        # Data - Encoding of the raw event data.
        prop :data, Attachment
        # Source - References the component or service that was the source of the event
        prop :source, ResourceReferenceChoice
        # Target - References the component or service that was the target of the event
        prop :target, ResourceReferenceChoice
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
