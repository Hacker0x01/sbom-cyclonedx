# frozen_string_literal: true
# rbs_inline: enabled

# Declarations - The list of declarations which describe the conformance to standards. Each declaration may include attestations, claims, and evidence.
module Sbom
  module Cyclonedx
    class Definitions < SchemaObject
      # Assessors - The list of assessors evaluating claims and determining conformance to requirements and confidence in that assessment.
      attr_accessor :assessors #: [Assessor]

      # Attestations - The list of attestations asserted by an assessor that maps requirements to claims.
      attr_accessor :attestations #: [Attestation]

      # Claims - The list of claims.
      attr_accessor :claims #: [Claim]

      # Evidence - The list of evidence
      attr_accessor :evidence #: [Evidence]

      # Targets - The list of targets which claims are made against.
      attr_accessor :targets #: Targets

      # Affirmation - A concise statement affirmed by an individual regarding all declarations, often used for third-party auditor acceptance or recipient acknowledgment. It includes a list of authorized signatories who assert the validity of the document on behalf of the organization.
      attr_accessor :affirmation #: Affirmation

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html)
      attr_accessor :signature #: Signature
    end
  end
end
