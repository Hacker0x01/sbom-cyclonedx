# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"
require_relative "service_data"

# Service
module SBOM
  module CycloneDX
    class Service < Struct.new(
      "Service",
      # BOM Reference - An optional identifier which can be used to reference the service elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Provider - The organization that provides the service.
      :provider,
      # Service Group - The grouping name, namespace, or identifier. This will often be a shortened, single name of the company or project that produced the service or domain name. Whitespace and special characters should be avoided.
      # Example: "com.acme"
      :group,
      # Service Name - The name of the service. This will often be a shortened, single name of the service.
      # Example: "ticker-service"
      :name,
      # Service Version - The service version.
      :version,
      # Service Description - Specifies a description for the service
      :description,
      # Endpoints - The endpoint URIs of the service. Multiple endpoints are allowed.
      :endpoints,
      # Authentication Required - A boolean value indicating if the service requires authentication. A value of true indicates the service requires authentication prior to use. A value of false indicates the service does not require authentication.
      :authenticated,
      # Crosses Trust Boundary - A boolean value indicating if use of the service crosses a trust zone or boundary. A value of true indicates that by using the service, a trust boundary is crossed. A value of false indicates that by using the service, a trust boundary is not crossed.
      :x_trust_boundary,
      # Trust Zone - The name of the trust zone the service resides in.
      :trust_zone,
      # Data - Specifies information about the data including the directional flow of data and the data classification.
      :data,
      # Service License(s)
      :licenses,
      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      :external_references,
      # Services - A list of services included or deployed behind the parent service. This is not a dependency tree. It provides a way to specify a hierarchical representation of service assemblies.
      :services,
      # Release notes - Specifies optional release notes.
      :release_notes,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      # Tags
      :tags,
      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      :signature,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"
      json_name :x_trust_boundary, "x-trust-boundary"

      def initialize(
        name:,
        bom_ref: nil,
        provider: nil,
        group: nil,
        version: nil,
        description: nil,
        endpoints: nil,
        authenticated: nil,
        x_trust_boundary: nil,
        trust_zone: nil,
        data: nil,
        licenses: nil,
        external_references: nil,
        services: nil,
        release_notes: nil,
        properties: nil,
        tags: nil,
        signature: nil
      )
        super
      end

      def valid? # rubocop:disable Metrics/PerceivedComplexity
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(OrganizationalEntity, provider) &&
          Validator.valid?(String, group) &&
          Validator.valid?(String, name, required: true) &&
          Validator.valid?(String, version) &&
          Validator.valid?(String, description) &&
          Validator.valid?(Array, endpoints, items: URI) &&
          Validator.valid?(SBOM::CycloneDX::Type::Boolean, authenticated) &&
          Validator.valid?(SBOM::CycloneDX::Type::Boolean, x_trust_boundary) &&
          Validator.valid?(String, trust_zone) &&
          Validator.valid?(Array, data, items: ServiceData) &&
          Validator.valid?(
            Array,
            licenses,
            items: ->(item) { LicenseChoice.valid?(item, required: true) }
          ) &&
          Validator.valid?(Array, external_references, items: ExternalReference) &&
          Validator.valid?(Array, services, unique: true, items: Service) &&
          Validator.valid?(ReleaseNotes, release_notes) &&
          Validator.valid?(Array, properties, items: Property) &&
          Validator.valid?(Array, tags, items: String) &&
          Signature.valid?(signature)
      end
    end
  end
end
