# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"
require_relative "service_data"

# Service
module SBOM
  module CycloneDX
    module Record
      # Schema name: Service
      class Service < Base
        # BOM Reference - An optional identifier which can be used to reference the service elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Provider - The organization that provides the service.
        prop :provider, OrganizationalEntity
        # Service Group - The grouping name, namespace, or identifier. This will often be a shortened, single name of the company or project that produced the service or domain name. Whitespace and special characters should be avoided.
        # Example: "com.acme"
        prop :group, :string
        # Service Name - The name of the service. This will often be a shortened, single name of the service.
        # Example: "ticker-service"
        prop :name, :string, required: true
        # Service Version - The service version.
        prop :version, :string
        # Service Description - Specifies a description for the service
        prop :description, :string
        # Endpoints - The endpoint URIs of the service. Multiple endpoints are allowed.
        prop :endpoints, :array, items: :uri
        # Authentication Required - A boolean value indicating if the service requires authentication. A value of true indicates the service requires authentication prior to use. A value of false indicates the service does not require authentication.
        prop :authenticated, :boolean
        # Crosses Trust Boundary - A boolean value indicating if use of the service crosses a trust zone or boundary. A value of true indicates that by using the service, a trust boundary is crossed. A value of false indicates that by using the service, a trust boundary is not crossed.
        prop :x_trust_boundary, :boolean, json_name: "x-trust-boundary"
        # Trust Zone - The name of the trust zone the service resides in.
        prop :trust_zone, :string
        # Data - Specifies information about the data including the directional flow of data and the data classification.
        prop :data, :array, items: ServiceData
        # Service License(s)
        prop :licenses, :array, items: [:union, of: LicenseChoice::UNION_TYPE]
        # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
        prop :external_references, :array, items: ExternalReference
        # Services - A list of services included or deployed behind the parent service. This is not a dependency tree. It provides a way to specify a hierarchical representation of service assemblies.
        prop :services, :array, items: Service
        # Release notes - Specifies optional release notes.
        prop :release_notes, ReleaseNotes
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
        # Tags
        prop :tags, :array, items: :string
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, :union, of: Signature::UNION_TYPE
      end
    end
  end
end
