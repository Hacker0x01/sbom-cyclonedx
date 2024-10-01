# frozen_string_literal: true
# rbs_inline: enabled

# Licensing information - Licensing details describing the licensor/licensee, license type, renewal and expiration dates, and other important metadata
module SBOM
  module Cyclonedx
    class Licensing < SchemaObject
      # Alternate License Identifiers - License identifiers that may be used to manage licenses and their lifecycle
      attr_accessor :alt_ids #: [String]

      # Licensor - The individual or organization that grants a license to another individual or organization
      attr_accessor :licensor #: Licensor

      # Licensee - The individual or organization for which a license was granted to
      attr_accessor :licensee #: Licensee

      # Purchaser - The individual or organization that purchased the license
      attr_accessor :purchaser #: Purchaser

      # Purchase Order - The purchase order identifier the purchaser sent to a supplier or vendor to authorize a purchase
      attr_accessor :purchase_order #: String

      # License Type - The type of license(s) that was granted to the licensee.
      attr_accessor :license_types #: [LicenseType]

      # Last Renewal - The timestamp indicating when the license was last renewed. For new purchases, this is often the purchase or acquisition date. For non-perpetual licenses or subscriptions, this is the timestamp of when the license was last renewed.
      attr_accessor :last_renewal #: DateTime

      # Expiration - The timestamp indicating when the current license expires (if applicable).
      attr_accessor :expiration #: DateTime
    end
  end
end
