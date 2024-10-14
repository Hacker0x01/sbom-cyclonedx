# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# License - Specifies the details and attributes related to a software license. It can either include a valid SPDX license identifier or a named license, along with additional properties such as license acknowledgment, comprehensive commercial licensing information, and the full text of the license.
module SBOM
  module CycloneDX
    class License < Struct.new(
      "License",
      # BOM Reference - An optional identifier which can be used to reference the license elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # License ID (SPDX) - A valid SPDX license identifier. If specified, this value must be one of the enumeration of valid SPDX license identifiers defined in the spdx.schema.json (or spdx.xml) subschema which is synchronized with the official SPDX license list.
      # Example: "Apache-2.0"
      :id,
      # License Name - The name of the license. This may include the name of a commercial or proprietary license or an open source license that may not be defined by SPDX.
      # Example: "Acme Software License"
      :name,
      :acknowledgement,
      # License text - An optional way to include the textual content of a license.
      :text,
      # License URL - The URL to the license file. If specified, a 'license' externalReference should also be specified for completeness
      # Example: ["https://www.apache.org/licenses/LICENSE-2.0.txt"]
      :url,
      # Licensing information - Licensing details describing the licensor/licensee, license type, renewal and expiration dates, and other important metadata
      :licensing,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def initialize(
        bom_ref: nil,
        id: nil,
        name: nil,
        acknowledgement: nil,
        text: nil,
        url: nil,
        licensing: nil,
        properties: nil
      )
        raise ArgumentError, "id or name must be specified" if id.nil? && name.nil?

        super
      end

      def valid? # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(String, id, enum: Enum::LICENSE_ID, required: name.nil?) &&
          Validator.valid?(String, name, required: id.nil?) &&
          Validator.valid?(String, acknowledgement, enum: Enum::LICENSE_ACKNOWLEDGEMENT) &&
          Validator.valid?(Attachment, text) &&
          Validator.valid?(URI, url) &&
          Validator.valid?(Licensing, licensing) &&
          Validator.valid?(Array, properties, items: Property)
      end

      class Licensing < Struct.new(
        "Licensing",
        # Alternate License Identifiers - License identifiers that may be used to manage licenses and their lifecycle
        :alt_ids,
        # Licensor - The individual or organization that grants a license to another individual or organization
        :licensor,
        # Licensee - The individual or organization for which a license was granted to
        :licensee,
        # Purchaser - The individual or organization that purchased the license
        :purchaser,
        # Purchase Order - The purchase order identifier the purchaser sent to a supplier or vendor to authorize a purchase
        :purchase_order,
        # License Type - The type of license(s) that was granted to the licensee.
        :license_types,
        # Last Renewal - The timestamp indicating when the license was last renewed. For new purchases, this is often the purchase or acquisition date. For non-perpetual licenses or subscriptions, this is the timestamp of when the license was last renewed.
        :last_renewal,
        # Expiration - The timestamp indicating when the current license expires (if applicable).
        :expiration,
        keyword_init: true
      )
        include SchemaObject

        def valid? # rubocop:disable Metrics/CyclomaticComplexity
          Validator.valid?(Array, alt_ids, items: String) &&
            Validator.valid?(Licensor, licensor) &&
            Validator.valid?(Licensee, licensee) &&
            Validator.valid?(Purchaser, purchaser) &&
            Validator.valid?(String, purchase_order) &&
            Validator.valid?(Array, license_types, items: [String, enum: Enum::LICENSE_TYPE]) &&
            Validator.valid?(DateTime, last_renewal) &&
            Validator.valid?(DateTime, expiration)
        end

        class Licensee < Struct.new(
          "Licensee",
          # Licensee (Organization) - The organization that was granted the license
          :organization,
          # Licensee (Individual) - The individual, not associated with an organization, that was granted the license
          :individual,
          keyword_init: true
        )
          include SchemaObject

          def initialize(organization: nil, individual: nil)
            raise ArgumentError, "organization or individual must be specified" if organization.nil? && individual.nil?

            super
          end

          def valid?
            Validator.valid?(OrganizationalEntity, organization, required: individual.nil?) &&
              Validator.valid?(OrganizationalContact, individual, required: organization.nil?)
          end
        end

        class Licensor < Struct.new(
          "Licensor",
          # Licensor (Organization) - The organization that granted the license
          :organization,
          # Licensor (Individual) - The individual, not associated with an organization, that granted the license
          :individual,
          keyword_init: true
        )
          include SchemaObject

          def initialize(organization: nil, individual: nil)
            raise ArgumentError, "organization or individual must be specified" if organization.nil? && individual.nil?

            super
          end

          def valid?
            Validator.valid?(OrganizationalEntity, organization, required: individual.nil?) &&
              Validator.valid?(OrganizationalContact, individual, required: organization.nil?)
          end
        end

        class Purchaser < Struct.new(
          "Purchaser",
          # Purchaser (Organization) - The organization that purchased the license
          :organization,
          # Purchaser (Individual) - The individual, not associated with an organization, that purchased the license
          :individual,
          keyword_init: true
        )
          include SchemaObject

          def initialize(organization: nil, individual: nil)
            raise ArgumentError, "organization or individual must be specified" if organization.nil? && individual.nil?

            super
          end

          def valid?
            Validator.valid?(OrganizationalEntity, organization, required: individual.nil?) &&
              Validator.valid?(OrganizationalContact, individual, required: organization.nil?)
          end
        end
      end
    end
  end
end
