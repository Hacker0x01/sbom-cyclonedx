# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "attachment"
require_relative "property"
require_relative "organizational_contact"
require_relative "organizational_entity"

# License - Specifies the details and attributes related to a software license. It can either include a valid SPDX license identifier or a named license, along with additional properties such as license acknowledgment, comprehensive commercial licensing information, and the full text of the license.
module SBOM
  module CycloneDX
    module Record
      # Schema name: License
      class License < Base
        # Schema name: Licensing
        class Licensing < Base
          # Schema name: Licensee
          class Licensee < Base
            # Licensee (Organization) - The organization that was granted the license
            prop :organization, OrganizationalEntity
            # Licensee (Individual) - The individual, not associated with an organization, that was granted the license
            prop :individual, OrganizationalContact

            validate :organization, :individual, presence: :any
          end

          # Schema name: Licensor
          class Licensor < Base
            # Licensor (Organization) - The organization that granted the license
            prop :organization, OrganizationalEntity
            # Licensor (Individual) - The individual, not associated with an organization, that granted the license
            prop :individual, OrganizationalContact

            validate :organization, :individual, presence: :any
          end

          # Schema name: Purchaser
          class Purchaser < Base
            # Purchaser (Organization) - The organization that purchased the license
            prop :organization, OrganizationalEntity
            # Purchaser (Individual) - The individual, not associated with an organization, that purchased the license
            prop :individual, OrganizationalContact

            validate :organization, :individual, presence: :any
          end

          # Alternate License Identifiers - License identifiers that may be used to manage licenses and their lifecycle
          prop :alt_ids, :array, items: :string
          # Licensor - The individual or organization that grants a license to another individual or organization
          prop :licensor, Licensor
          # Licensee - The individual or organization for which a license was granted to
          prop :licensee, Licensee
          # Purchaser - The individual or organization that purchased the license
          prop :purchaser, Purchaser
          # Purchase Order - The purchase order identifier the purchaser sent to a supplier or vendor to authorize a purchase
          prop :purchase_order, :string
          # License Type - The type of license(s) that was granted to the licensee.
          prop :license_types, :array, items: [:string, enum: Enum::LICENSE_TYPE]
          # Last Renewal - The timestamp indicating when the license was last renewed. For new purchases, this is often the purchase or acquisition date. For non-perpetual licenses or subscriptions, this is the timestamp of when the license was last renewed.
          prop :last_renewal, :date_time
          # Expiration - The timestamp indicating when the current license expires (if applicable).
          prop :expiration, :date_time
        end

        # BOM Reference - An optional identifier which can be used to reference the license elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # License ID (SPDX) - A valid SPDX license identifier. If specified, this value must be one of the enumeration of valid SPDX license identifiers defined in the spdx.schema.json (or spdx.xml) subschema which is synchronized with the official SPDX license list.
        # Example: "Apache-2.0"
        prop :id, :string, enum: Enum::LICENSE_ID
        # License Name - The name of the license. This may include the name of a commercial or proprietary license or an open source license that may not be defined by SPDX.
        # Example: "Acme Software License"
        prop :name, :string
        prop :acknowledgement, :string, enum: Enum::LICENSE_ACKNOWLEDGEMENT
        # License text - An optional way to include the textual content of a license.
        prop :text, Attachment
        # License URL - The URL to the license file. If specified, a 'license' externalReference should also be specified for completeness
        # Example: ["https://www.apache.org/licenses/LICENSE-2.0.txt"]
        prop :url, :uri
        # Licensing information - Licensing details describing the licensor/licensee, license type, renewal and expiration dates, and other important metadata
        prop :licensing, Licensing
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property

        validate :id, :name, presence: :any
      end
    end
  end
end
