# frozen_string_literal: true
# rbs_inline: enabled

# Affirmation - A concise statement affirmed by an individual regarding all declarations, often used for third-party auditor acceptance or recipient acknowledgment. It includes a list of authorized signatories who assert the validity of the document on behalf of the organization.
module Sbom
  module Cyclonedx
    class Affirmation < SchemaObject
      # Statement - The brief statement affirmed by an individual regarding all declarations.\n*- Notes This could be an affirmation of acceptance by a third-party auditor or receiving individual of a file.
      # Example: "I certify, to the best of my knowledge, that all information is correct."
      attr_accessor :statement #: String

      # Signatories - The list of signatories authorized on behalf of an organization to assert validity of this document.
      attr_accessor :signatories #: [Signatory]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature
    end
  end
end
