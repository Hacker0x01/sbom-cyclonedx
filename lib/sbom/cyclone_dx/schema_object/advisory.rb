# frozen_string_literal: true

require_relative "../schema_object"

# Advisory - Title and location where advisory information can be obtained. An advisory is a notification of a threat to a component, service, or system.
module SBOM
  module CycloneDX
    class Advisory < SchemaObject.build("Advisory", :title, :url)
      include SchemaObject::InstanceMethods
      extend SchemaObject::ClassMethods

      required :url
    end
  end
end
