# frozen_string_literal: true
# rbs_inline: enabled

# Risk
module Sbom
  module Cyclonedx
    class Risk < SchemaObject
      # Name - The name of the risk.
      attr_accessor :name #: String

      # Mitigation Strategy - Strategy used to address this risk.
      attr_accessor :mitigation_strategy #: String
    end
  end
end
