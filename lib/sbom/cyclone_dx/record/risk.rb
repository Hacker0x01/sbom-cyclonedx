# frozen_string_literal: true

require_relative "base"

# Risk
module SBOM
  module CycloneDX
    module Record
      # Schema name: Risk
      class Risk < Base
        # Name - The name of the risk.
        prop :name, :string
        # Mitigation Strategy - Strategy used to address this risk.
        prop :mitigation_strategy, :string
      end
    end
  end
end
