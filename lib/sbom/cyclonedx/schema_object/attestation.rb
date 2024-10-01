# frozen_string_literal: true
# rbs_inline: enabled

# Attestation - Maps requirements to claims and provides conformance and confidence scores.
module SBOM
  module Cyclonedx
    class Attestation < SchemaObject
      # Summary - The short description explaining the main points of the attestation.
      attr_accessor :summary #: String

      # Assessor - The `bom-ref` to the assessor asserting the attestation.
      attr_accessor :assessor #: RefLink

      # Map - The grouping of requirements to claims and the attestors declared conformance and confidence thereof.
      attr_accessor :map #: [Map]

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
      attr_accessor :signature #: Signature

      class Map < SchemaObject
        # Requirement - The `bom-ref` to the requirement being attested to.
        attr_accessor :requirement #: RefLink

        # Claims - The list of `bom-ref` to the claims being attested to.
        attr_accessor :claims #: [RefLink]

        # Counter Claims - The list of  `bom-ref` to the counter claims being attested to.
        attr_accessor :counter_claims #: [RefLink]

        # Conformance - The conformance of the claim meeting a requirement.
        attr_accessor :conformance #: Conformance

        # Confidence - The confidence of the claim meeting the requirement.
        attr_accessor :confidence #: Confidence

        class Conformance < SchemaObject
          # Score - The conformance of the claim between and inclusive of 0 and 1, where 1 is 100% conformance.
          attr_accessor :score #: Float

          validate :score, minimum: 0, maximum: 1

          # Rationale - The rationale for the conformance score.
          attr_accessor :rationale #: String

          # Mitigation Strategies - The list of  `bom-ref` to the evidence provided describing the mitigation strategies.
          attr_accessor :mitigation_strategies #: [RefLink]
        end

        class Confidence < SchemaObject
          # Score - The confidence of the claim between and inclusive of 0 and 1, where 1 is 100% confidence.
          attr_accessor :score #: Float

          validate :score, minimum: 0, maximum: 1

          # Rationale - The rationale for the confidence score.
          attr_accessor :rationale #: String
        end
      end
    end
  end
end
