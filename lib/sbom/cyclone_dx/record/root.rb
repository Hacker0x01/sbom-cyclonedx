# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"
require_relative "metadata"
require_relative "component"
require_relative "service"
require_relative "external_reference"
require_relative "dependency"
require_relative "composition"
require_relative "vulnerability"
require_relative "annotation"
require_relative "formula"
require_relative "declarations"
require_relative "definitions"
require_relative "signature"
require_relative "property"

# CycloneDX Bill of Materials Standard
module SBOM
  module CycloneDX
    module Record
      # Schema name: Root
      class Root < Base
        # BOM Serial Number - Every BOM generated SHOULD have a unique serial number, even if the contents of the BOM have not changed over time. If specified, the serial number must conform to [RFC 4122](https://www.ietf.org/rfc/rfc4122.html). Use of serial numbers is recommended.
        prop :serial_number,
             :string,
             pattern: Pattern::BOM_SERIAL_NUMBER,
             default: -> { "urn:uuid:#{SecureRandom.uuid}" }
        # Version - Whenever an existing BOM is modified, either manually or through automated processes, the version of the BOM SHOULD be incremented by 1. When a system is presented with multiple BOMs with identical serial numbers, the system SHOULD use the most recent version of the BOM. The default version is '1'.
        prop :version, :integer, minimum: 1, required: true, default: 1
        # BOM Metadata - Provides additional information about a BOM.
        prop :metadata, Metadata
        # Components - A list of software and hardware components.
        prop :components, :array, items: Component, unique: true
        # Services - A list of services. This may include microservices, function-as-a-service, and other types of network or intra-process services.
        prop :services, :array, items: Service, unique: true
        # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
        prop :external_references, :array, items: ExternalReference
        # Dependencies - Provides the ability to document dependency relationships including provided & implemented components.
        prop :dependencies, :array, items: Dependency, unique: true
        # Compositions - Compositions describe constituent parts (including components, services, and dependency relationships) and their completeness. The completeness of vulnerabilities expressed in a BOM may also be described.
        prop :compositions, :array, items: Composition, unique: true
        # Vulnerabilities - Vulnerabilities identified in components or services.
        prop :vulnerabilities, :array, items: Vulnerability, unique: true
        # Annotations - Comments made by people, organizations, or tools about any object with a bom-ref, such as components, services, vulnerabilities, or the BOM itself. Unlike inventory information, annotations may contain opinions or commentary from various stakeholders. Annotations may be inline (with inventory) or externalized via BOM-Link and may optionally be signed.
        prop :annotations, :array, items: Annotation, unique: true
        # Formulation - Describes how a component or service was manufactured or deployed. This is achieved through the use of formulas, workflows, tasks, and steps, which declare the precise steps to reproduce along with the observed formulas describing the steps which transpired in the manufacturing process.
        prop :formulation, :array, items: Formula, unique: true
        # Declarations - The list of declarations which describe the conformance to standards. Each declaration may include attestations, claims, and evidence.
        prop :declarations, Declarations
        # Definitions - A collection of reusable objects that are defined and may be used elsewhere in the BOM.
        prop :definitions, Definitions
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, :union, of: Signature::UNION_TYPE
        const :bom_format, :string, "CycloneDX"
        const :spec_version, :string, "1.6"
      end
    end
  end
end
