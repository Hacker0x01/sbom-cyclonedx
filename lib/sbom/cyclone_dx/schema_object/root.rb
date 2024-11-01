# frozen_string_literal: true

require_relative "../pattern"
require_relative "../schema_object"
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
    class Root < Struct.new(
      "Root",
      # BOM Serial Number - Every BOM generated SHOULD have a unique serial number, even if the contents of the BOM have not changed over time. If specified, the serial number must conform to [RFC 4122](https://www.ietf.org/rfc/rfc4122.html). Use of serial numbers is recommended.
      :serial_number,
      # Version - Whenever an existing BOM is modified, either manually or through automated processes, the version of the BOM SHOULD be incremented by 1. When a system is presented with multiple BOMs with identical serial numbers, the system SHOULD use the most recent version of the BOM. The default version is '1'.
      :version,
      # BOM Metadata - Provides additional information about a BOM.
      :metadata,
      # Components - A list of software and hardware components.
      :components,
      # Services - A list of services. This may include microservices, function-as-a-service, and other types of network or intra-process services.
      :services,
      # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
      :external_references,
      # Dependencies - Provides the ability to document dependency relationships including provided & implemented components.
      :dependencies,
      # Compositions - Compositions describe constituent parts (including components, services, and dependency relationships) and their completeness. The completeness of vulnerabilities expressed in a BOM may also be described.
      :compositions,
      # Vulnerabilities - Vulnerabilities identified in components or services.
      :vulnerabilities,
      # Annotations - Comments made by people, organizations, or tools about any object with a bom-ref, such as components, services, vulnerabilities, or the BOM itself. Unlike inventory information, annotations may contain opinions or commentary from various stakeholders. Annotations may be inline (with inventory) or externalized via BOM-Link and may optionally be signed.
      :annotations,
      # Formulation - Describes how a component or service was manufactured or deployed. This is achieved through the use of formulas, workflows, tasks, and steps, which declare the precise steps to reproduce along with the observed formulas describing the steps which transpired in the manufacturing process.
      :formulation,
      # Declarations - The list of declarations which describe the conformance to standards. Each declaration may include attestations, claims, and evidence.
      :declarations,
      # Definitions - A collection of reusable objects that are defined and may be used elsewhere in the BOM.
      :definitions,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      :signature,
      :bom_format,
      :spec_version,
      keyword_init: true
    )
      include SchemaObject

      def initialize( # rubocop:disable Metrics/MethodLength
        serial_number: nil,
        version: 1,
        metadata: nil,
        components: nil,
        services: nil,
        external_references: nil,
        dependencies: nil,
        compositions: nil,
        vulnerabilities: nil,
        annotations: nil,
        formulation: nil,
        declarations: nil,
        definitions: nil,
        properties: nil,
        signature: nil
      )
        serial_number ||= "urn:uuid:#{SecureRandom.uuid}"

        super(
          serial_number: serial_number,
          version: version,
          metadata: metadata,
          components: components,
          services: services,
          external_references: external_references,
          dependencies: dependencies,
          compositions: compositions,
          vulnerabilities: vulnerabilities,
          annotations: annotations,
          formulation: formulation,
          declarations: declarations,
          definitions: definitions,
          properties: properties,
          signature: signature,
          bom_format: "CycloneDX",
          spec_version: "1.6"
        )
      end

      def valid? # rubocop:disable Metrics/PerceivedComplexity
        Validator.valid?(String, serial_number, pattern: Pattern::BOM_SERIAL_NUMBER) &&
          Validator.valid?(Integer, version, minimum: 1, required: true) &&
          Validator.valid?(Metadata, metadata) &&
          Validator.valid?(Array, components, unique: true, items: Component) &&
          Validator.valid?(Array, services, unique: true, items: Service) &&
          Validator.valid?(Array, external_references) &&
          Validator.valid?(Array, dependencies, unique: true, items: Dependency) &&
          Validator.valid?(Array, compositions, unique: true, items: Composition) &&
          Validator.valid?(Array, vulnerabilities, unique: true, items: Vulnerability) &&
          Validator.valid?(Array, annotations, unique: true, items: Annotation) &&
          Validator.valid?(Array, formulation, unique: true, items: Formula) &&
          Validator.valid?(Declarations, declarations) &&
          Validator.valid?(Definitions, definitions) &&
          Validator.valid?(Array, properties) &&
          Signature.valid?(signature) &&
          Validator.valid?(String, bom_format, const: "CycloneDX", required: true) &&
          Validator.valid?(String, spec_version, const: "1.6", required: true)
      end
    end
  end
end
