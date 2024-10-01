# frozen_string_literal: true
# rbs_inline: enabled

# Component
module SBOM
  module Cyclonedx
    class Component < SchemaObject
      # Component Type - Specifies the type of component. For software components, classify as application if no more specific appropriate classification is available or cannot be determined for the component.
      attr_accessor :type #: ComponentType

      # Mime-Type - The optional mime-type of the component. When used on file components, the mime-type can provide additional context about the kind of file being represented, such as an image, font, or executable. Some library or framework components may also have an associated mime-type.
      attr_accessor :mime_type #: MimeType

      # BOM Reference - An optional identifier which can be used to reference the component elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Component Supplier -  The organization that supplied the component. The supplier may often be the manufacturer, but may also be a distributor or repackager.
      attr_accessor :supplier #: OrganizationalEntity

      # Component Manufacturer - The organization that created the component. Manufacturer is common in components created through automated processes. Components created through manual means may have `@.authors` instead.
      attr_accessor :manufacturer #: OrganizationalEntity

      # Component Authors - The person(s) who created the component. Authors are common in components created through manual processes. Components created through automated means may have `@.manufacturer` instead.
      attr_accessor :authors #: [OrganizationalContact]

      # Component Publisher - The person(s) or organization(s) that published the component
      # Example: "Acme Inc"
      attr_accessor :publisher #: String

      # Component Group - The grouping name or identifier. This will often be a shortened, single name of the company or project that produced the component, or the source package or domain name. Whitespace and special characters should be avoided. Examples include: apache, org.apache.commons, and apache.org.
      # Example: "com.acme"
      attr_accessor :group #: String

      # Component Name - The name of the component. This will often be a shortened, single name of the component. Examples: commons-lang3 and jquery
      # Example: "tomcat-catalina"
      attr_accessor :name #: String

      # Component Version - The component version. The version should ideally comply with semantic versioning but is not enforced.
      attr_accessor :version #: String

      # Component Description - Specifies a description for the component
      attr_accessor :description #: String

      # Component Scope - Specifies the scope of the component. If scope is not specified, 'required' scope SHOULD be assumed by the consumer of the BOM.
      attr_accessor :scope #: Scope

      # Component Hashes - The hashes of the component.
      attr_accessor :hashes #: [Hash]

      # Component License(s)
      attr_accessor :licenses #: LicenseChoice

      # Component Copyright - A copyright notice informing users of the underlying claims to copyright ownership in a published work.
      # Example: "Acme Inc"
      attr_accessor :copyright #: String

      # Common Platform Enumeration (CPE) - Asserts the identity of the component using CPE. The CPE must conform to the CPE 2.2 or 2.3 specification. See [https://nvd.nist.gov/products/cpe](https://nvd.nist.gov/products/cpe). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      # Example: "cpe:2.3:a:acme:component_framework:-:*:*:*:*:*:*:*"
      # TODO: Validate
      attr_accessor :cpe #: String

      # Package URL (purl) - Asserts the identity of the component using package-url (purl). The purl, if specified, must be valid and conform to the specification defined at: [https://github.com/package-url/purl-spec](https://github.com/package-url/purl-spec). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      # Example: "pkg:maven/com.acme/tomcat-catalina@9.0.14?packaging=jar"
      # TODO: Validate
      attr_accessor :purl #: String

      # OmniBOR Artifact Identifier (gitoid) - Asserts the identity of the component using the OmniBOR Artifact ID. The OmniBOR, if specified, must be valid and conform to the specification defined at: [https://www.iana.org/assignments/uri-schemes/prov/gitoid](https://www.iana.org/assignments/uri-schemes/prov/gitoid). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      # Examples:
      #   "gitoid:blob:sha1:a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
      #   "gitoid:blob:sha256:9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"
      # TODO: Validate
      attr_accessor :omnibor_id #: [String]

      # Software Heritage Identifier - Asserts the identity of the component using the Software Heritage persistent identifier (SWHID). The SWHID, if specified, must be valid and conform to the specification defined at: [https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html](https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      # Example: "swh:1:cnt:94a9ed024d3859793618152ea559a168bbcbb5e2"
      # TODO: Validate
      attr_accessor :swhid #: [String]

      # SWID Tag - Asserts the identity of the component using [ISO-IEC 19770-2 Software Identification (SWID) Tags](https://www.iso.org/standard/65666.html). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      attr_accessor :swid #: Swid

      # Component Modified From Original - [Deprecated] This will be removed in a future version. Use the pedigree element instead to supply information on exactly how the component was modified. A boolean value indicating if the component has been modified from the original. A value of true indicates the component is a derivative of the original. A value of false indicates the component has not been modified from the original.
      attr_accessor :modified #: bool

      # Component Pedigree - Component pedigree is a way to document complex supply chain scenarios where components are created, distributed, modified, redistributed, combined with other components, etc. Pedigree supports viewing this complex chain from the beginning, the end, or anywhere in the middle. It also provides a way to document variants where the exact relation may not be known.
      attr_accessor :pedigree #: Pedigree

      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      attr_accessor :external_references #: [ExternalReference]

      # Components - A list of software and hardware components included in the parent component. This is not a dependency tree. It provides a way to specify a hierarchical representation of component assemblies, similar to system &#8594; subsystem &#8594; parts assembly in physical supply chains.
      attr_accessor :components #: Set[Component]

      # Evidence - Provides the ability to document evidence collected through various forms of extraction or analysis.
      attr_accessor :evidence #: ComponentEvidence

      # Release notes - Specifies optional release notes.
      attr_accessor :release_notes #: ReleaseNote

      # AI/ML Model Card
      attr_accessor :model_card #: ModelCard

      # Data - This object SHOULD be specified for any component of type `data` and must not be specified for other component types.
      attr_accessor :data #: [ComponentData]

      # Cryptographic Properties
      attr_accessor :crypto_properties #: CryptoProperty

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]

      # Tags
      attr_accessor :tags #: Tag

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature
    end
  end
end
