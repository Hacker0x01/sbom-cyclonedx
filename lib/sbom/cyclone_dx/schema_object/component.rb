# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"
require_relative "component_data"
require_relative "component_evidence"
require_relative "crypto_properties"
require_relative "external_reference"
require_relative "hash_data"
require_relative "license_choice"
require_relative "model_card"
require_relative "organizational_contact"
require_relative "organizational_entity"
require_relative "patch"
require_relative "property"
require_relative "release_notes"
require_relative "signature"
require_relative "swid"

# Component
module SBOM
  module CycloneDX
    class Component < Struct.new( # rubocop:disable Metrics/ClassLength
      "Component",
      # Component Type - Specifies the type of component. For software components, classify as application if no more specific appropriate classification is available or cannot be determined for the component.
      :type,
      # Mime-Type - The optional mime-type of the component. When used on file components, the mime-type can provide additional context about the kind of file being represented, such as an image, font, or executable. Some library or framework components may also have an associated mime-type.
      # TODO: Use a mime-type gem
      :mime_type,
      # BOM Reference - An optional identifier which can be used to reference the component elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Component Supplier -  The organization that supplied the component. The supplier may often be the manufacturer, but may also be a distributor or repackager.
      :supplier,
      # Component Manufacturer - The organization that created the component. Manufacturer is common in components created through automated processes. Components created through manual means may have `@.authors` instead.
      :manufacturer,
      # Component Authors - The person(s) who created the component. Authors are common in components created through manual processes. Components created through automated means may have `@.manufacturer` instead.
      :authors,
      # Component Publisher - The person(s) or organization(s) that published the component
      # Example: "Acme Inc"
      :publisher,
      # Component Group - The grouping name or identifier. This will often be a shortened, single name of the company or project that produced the component, or the source package or domain name. Whitespace and special characters should be avoided. Examples include: apache, org.apache.commons, and apache.org.
      # Example: "com.acme"
      :group,
      # Component Name - The name of the component. This will often be a shortened, single name of the component. Examples: commons-lang3 and jquery
      # Example: "tomcat-catalina"
      :name,
      # Component Version - The component version. The version should ideally comply with semantic versioning but is not enforced.
      :version,
      # Component Description - Specifies a description for the component
      :description,
      # Component Scope - Specifies the scope of the component. If scope is not specified, 'required' scope SHOULD be assumed by the consumer of the BOM.
      :scope,
      # Component Hashes - The hashes of the component.
      :hashes,
      # Component License(s)
      :licenses,
      # Component Copyright - A copyright notice informing users of the underlying claims to copyright ownership in a published work.
      # Example: "Acme Inc"
      :copyright,
      # Common Platform Enumeration (CPE) - Asserts the identity of the component using CPE. The CPE must conform to the CPE 2.2 or 2.3 specification. See [https://nvd.nist.gov/products/cpe](https://nvd.nist.gov/products/cpe). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      # Example: "cpe:2.3:a:acme:component_framework:-:*:*:*:*:*:*:*"
      # TODO: Validate
      :cpe,
      # Package URL (purl) - Asserts the identity of the component using package-url (purl). The purl, if specified, must be valid and conform to the specification defined at: [https://github.com/package-url/purl-spec](https://github.com/package-url/purl-spec). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      # Example: "pkg:maven/com.acme/tomcat-catalina@9.0.14?packaging=jar"
      # TODO: Validate
      :purl,
      # OmniBOR Artifact Identifier (gitoid) - Asserts the identity of the component using the OmniBOR Artifact ID. The OmniBOR, if specified, must be valid and conform to the specification defined at: [https://www.iana.org/assignments/uri-schemes/prov/gitoid](https://www.iana.org/assignments/uri-schemes/prov/gitoid). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      # Examples:
      #   "gitoid:blob:sha1:a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
      #   "gitoid:blob:sha256:9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"
      # TODO: Validate
      :omnibor_id,
      # Software Heritage Identifier - Asserts the identity of the component using the Software Heritage persistent identifier (SWHID). The SWHID, if specified, must be valid and conform to the specification defined at: [https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html](https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      # Example: "swh:1:cnt:94a9ed024d3859793618152ea559a168bbcbb5e2"
      # TODO: Validate
      :swhid,
      # SWID Tag - Asserts the identity of the component using [ISO-IEC 19770-2 Software Identification (SWID) Tags](https://www.iso.org/standard/65666.html). Refer to `@.evidence.identity` to optionally provide evidence that substantiates the assertion of the component's identity.
      :swid,
      # Component Modified From Original - [Deprecated] This will be removed in a future version. Use the pedigree element instead to supply information on exactly how the component was modified. A boolean value indicating if the component has been modified from the original. A value of true indicates the component is a derivative of the original. A value of false indicates the component has not been modified from the original.
      :modified,
      # Component Pedigree - Component pedigree is a way to document complex supply chain scenarios where components are created, distributed, modified, redistributed, combined with other components, etc. Pedigree supports viewing this complex chain from the beginning, the end, or anywhere in the middle. It also provides a way to document variants where the exact relation may not be known.
      :pedigree,
      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      :external_references,
      # Components - A list of software and hardware components included in the parent component. This is not a dependency tree. It provides a way to specify a hierarchical representation of component assemblies, similar to system &#8594; subsystem &#8594; parts assembly in physical supply chains.
      :components,
      # Evidence - Provides the ability to document evidence collected through various forms of extraction or analysis.
      :evidence,
      # Release notes - Specifies optional release notes.
      :release_notes,
      # AI/ML Model Card
      :model_card,
      # Data - This object SHOULD be specified for any component of type `data` and must not be specified for other component types.
      :data,
      # Cryptographic Properties
      :crypto_properties,
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
      json_name :mime_type, "mime-type"

      def initialize(
        type:,
        name:,
        scope: "required",
        mime_type: nil,
        bom_ref: nil,
        supplier: nil,
        manufacturer: nil,
        authors: nil,
        publisher: nil,
        group: nil,
        version: nil,
        description: nil,
        hashes: nil,
        licenses: nil,
        copyright: nil,
        cpe: nil,
        purl: nil,
        omnibor_id: nil,
        swhid: nil,
        swid: nil,
        modified: nil,
        pedigree: nil,
        external_references: nil,
        components: nil,
        evidence: nil,
        release_notes: nil,
        model_card: nil,
        data: nil,
        crypto_properties: nil,
        properties: nil,
        tags: nil,
        signature: nil
      )
        super
      end

      def valid? # rubocop:disable Metrics/PerceivedComplexity
        Validator.valid?(String, type, enum: Enum::COMPONENT_TYPE, required: true) &&
          Validator.valid?(String, mime_type, pattern: Pattern::MIME_TYPE) &&
          Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(OrganizationalEntity, supplier) &&
          Validator.valid?(OrganizationalEntity, manufacturer) &&
          Validator.valid?(Array, authors, items: OrganizationalContact) &&
          Validator.valid?(String, publisher) &&
          Validator.valid?(String, group) &&
          Validator.valid?(String, name, required: true) &&
          Validator.valid?(String, version) &&
          Validator.valid?(String, description) &&
          Validator.valid?(String, scope, enum: Enum::SCOPE) &&
          Validator.valid?(Array, hashes, items: HashData) &&
          Validator.valid?(Array, licenses, items: ->(item) { LicenseChoice.valid?(item, required: true) }) &&
          Validator.valid?(String, copyright) &&
          Validator.valid?(String, cpe) &&
          Validator.valid?(String, purl) &&
          Validator.valid?(Array, omnibor_id, items: String) &&
          Validator.valid?(Array, swhid, items: String) &&
          Validator.valid?(SWID, swid) &&
          Validator.valid?(SBOM::CycloneDX::Type::Boolean, modified) &&
          Validator.valid?(Pedigree, pedigree) &&
          Validator.valid?(Array, external_references, items: ExternalReference) &&
          Validator.valid?(Array, components, unique: true, items: Component) &&
          Validator.valid?(ComponentEvidence, evidence) &&
          Validator.valid?(ReleaseNotes, release_notes) &&
          Validator.valid?(ModelCard, model_card) &&
          Validator.valid?(Array, data, items: ComponentData) &&
          Validator.valid?(CryptoProperties, crypto_properties) &&
          Validator.valid?(Array, properties, items: Property) &&
          Validator.valid?(Array, tags, items: String) &&
          Signature.valid?(signature)
      end

      class Pedigree < Struct.new(
        "Pedigree",
        # Ancestors - Describes zero or more components in which a component is derived from. This is commonly used to describe forks from existing projects where the forked version contains a ancestor node containing the original component it was forked from. For example, Component A is the original component. Component B is the component being used and documented in the BOM. However, Component B contains a pedigree node with a single ancestor documenting Component A - the original component from which Component B is derived from.
        :ancestors,
        # Descendants - Descendants are the exact opposite of ancestors. This provides a way to document all forks (and their forks) of an original or root component.
        :descendants,
        # Variants - Variants describe relations where the relationship between the components is not known. For example, if Component A contains nearly identical code to Component B. They are both related, but it is unclear if one is derived from the other, or if they share a common ancestor.
        :variants,
        # Commits - A list of zero or more commits which provide a trail describing how the component deviates from an ancestor, descendant, or variant.
        :commits,
        # Patches - A list of zero or more patches describing how the component deviates from an ancestor, descendant, or variant. Patches may be complementary to commits or may be used in place of commits.
        :patches,
        # Notes - Notes, observations, and other non-structured commentary describing the components pedigree.
        :notes,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(Array, ancestors, items: Component) &&
            Validator.valid?(Array, descendants, items: Component) &&
            Validator.valid?(Array, variants, items: Component) &&
            Validator.valid?(Array, commits, items: Commit) &&
            Validator.valid?(Array, patches, items: Patch) &&
            Validator.valid?(String, notes)
        end
      end
    end
  end
end
