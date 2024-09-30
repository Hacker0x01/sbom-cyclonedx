# frozen_string_literal: true
# rbs_inline: enabled

# License - Specifies the details and attributes related to a software license. It can either include a valid SPDX license identifier or a named license, along with additional properties such as license acknowledgment, comprehensive commercial licensing information, and the full text of the license.
module Sbom
  module Cyclonedx
    class License < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the license elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # License ID (SPDX) - A valid SPDX license identifier. If specified, this value must be one of the enumeration of valid SPDX license identifiers defined in the spdx.schema.json (or spdx.xml) subschema which is synchronized with the official SPDX license list.
      # Example: "Apache-2.0"
      attr_accessor :id #: LicenseID

      # License Name - The name of the license. This may include the name of a commercial or proprietary license or an open source license that may not be defined by SPDX.
      # Example: "Acme Software License"
      attr_accessor :name #: String

      attr_accessor :acknowledgement #: LicenseAcknowledgementEnumeration

      # License text - An optional way to include the textual content of a license.
      attr_accessor :text #: Attachment

      # License URL - The URL to the license file. If specified, a 'license' externalReference should also be specified for completeness
      # Example: ["https://www.apache.org/licenses/LICENSE-2.0.txt"]
      attr_accessor :url #: URI

      # Licensing information - Licensing details describing the licensor/licensee, license type, renewal and expiration dates, and other important metadata
      attr_accessor :licensing #: Licensing

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
