# frozen_string_literal: true
# rbs_inline: enabled

# CycloneDX Bill of Materials Standard
module Sbom
  module Cyclonedx
    class Root < SchemaObject
      # BOM Serial Number - Every BOM generated SHOULD have a unique serial number, even if the contents of the BOM have not changed over time. If specified, the serial number must conform to [RFC 4122](https://www.ietf.org/rfc/rfc4122.html). Use of serial numbers is recommended.
      attr_accessor :serial_number #: BOMSerialNumber

      default :serial_number, -> { BOMSerialNumber.new("urn:uuid:#{SecureRandom.uuid}") }

      # Version - Whenever an existing BOM is modified, either manually or through automated processes, the version of the BOM SHOULD be incremented by 1. When a system is presented with multiple BOMs with identical serial numbers, the system SHOULD use the most recent version of the BOM. The default version is '1'.
      attr_accessor :version #: Integer

      validate :version, minimum: 1, required: true
      default :version, 1

      # BOM Metadata - Provides additional information about a BOM.
      attr_accessor :metadata #: Metadata

      # Components - A list of software and hardware components.
      attr_accessor :components #: Set[Component]

      # Services - A list of services. This may include microservices, function-as-a-service, and other types of network or intra-process services.
      attr_accessor :services #: Set[Service]

      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      attr_accessor :external_references #: [ExternalReference]

      # Dependencies - Provides the ability to document dependency relationships including provided & implemented components.
      attr_accessor :dependencies #: Set[Dependency]

      # Compositions - Compositions describe constituent parts (including components, services, and dependency relationships) and their completeness. The completeness of vulnerabilities expressed in a BOM may also be described.
      attr_accessor :compositions #: Set[Composition]

      # Vulnerabilities - Vulnerabilities identified in components or services.
      attr_accessor :vulnerabilities #: Set[Vulnerability]

      # Annotations - Comments made by people, organizations, or tools about any object with a bom-ref, such as components, services, vulnerabilities, or the BOM itself. Unlike inventory information, annotations may contain opinions or commentary from various stakeholders. Annotations may be inline (with inventory) or externalized via BOM-Link and may optionally be signed.
      attr_accessor :annotations #: Set[Annotation]

      # Formulation - Describes how a component or service was manufactured or deployed. This is achieved through the use of formulas, workflows, tasks, and steps, which declare the precise steps to reproduce along with the observed formulas describing the steps which transpired in the manufacturing process.
      attr_accessor :formulation #: Set[Formula]

      # Declarations - The list of declarations which describe the conformance to standards. Each declaration may include attestations, claims, and evidence.
      attr_accessor :declarations #: Declarations

      # Definitions - A collection of reusable objects that are defined and may be used elsewhere in the BOM.
      attr_accessor :definitions #: Definitions

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature

      def s_schema
        "https://cyclonedx.org/schema/bom/1.6"
      end

      def bom_format
        "CycloneDX"
      end

      def spec_version
        "1.6"
      end
    end
  end
end
