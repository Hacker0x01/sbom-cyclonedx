# frozen_string_literal: true

require_relative "../schema_object"
require_relative "attachment"
require_relative "property"
require_relative "resource_reference_choice"

# Event - Represents something that happened that may trigger a response.
module SBOM
  module CycloneDX
    class Event < Struct.new(
      "Event",
      # Unique Identifier (UID) - The unique identifier of the event.
      :uid,
      # Description - A description of the event.
      :description,
      # Time Received - The date and time (timestamp) when the event was received.
      :time_received,
      # Data - Encoding of the raw event data.
      :data,
      # Source - References the component or service that was the source of the event
      :source,
      # Target - References the component or service that was the target of the event
      :target,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, uid) &&
          Validator.valid?(String, description) &&
          Validator.valid?(DateTime, time_received) &&
          Validator.valid?(Attachment, data) &&
          Validator.valid?(ResourceReferenceChoice, source) &&
          Validator.valid?(ResourceReferenceChoice, target) &&
          Validator.valid?(Array, properties, items: Property)
      end
    end
  end
end
