# frozen_string_literal: true
# rbs_inline: enabled

# Proof of Concept - Evidence used to reproduce the vulnerability.
module Sbom
  module Cyclonedx
    class ProofOfConcept < SchemaObject
      # Steps to Reproduce - Precise steps to reproduce the vulnerability.
      attr_accessor :reproduction_steps #: String

      # Environment - A description of the environment in which reproduction was possible.
      attr_accessor :environment #: String

      # Supporting Material - Supporting material that helps in reproducing or understanding how reproduction is possible. This may include screenshots, payloads, and PoC exploit code.
      attr_accessor :supporting_material #: [Attachment]
    end
  end
end
