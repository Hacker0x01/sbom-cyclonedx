# frozen_string_literal: true

require_relative "../email_address_extension"
require_relative "cyclone_dx/enum"
require_relative "cyclone_dx/field"
require_relative "cyclone_dx/pattern"
require_relative "cyclone_dx/record"
require_relative "cyclone_dx/validator"
require_relative "cyclone_dx/version"

# Disable DNS lookup and host validation for the EmailAddress gem, so we don't accidentally hit the network.
# We also override this in the EmailAddressExtension module, but this is a good safety net.
(_ = EmailAddress::Config).configure({ dns_lookup: :off, host_validation: :syntax })

module SBOM
  module CycloneDX
    class Error < StandardError; end

    class << self
      def create(hash)
        Record::Root.new(**hash)
      end

      def load(file)
        Record::Root.load(file)
      end

      def parse(string)
        Record::Root.parse(string)
      end
    end
  end
end
