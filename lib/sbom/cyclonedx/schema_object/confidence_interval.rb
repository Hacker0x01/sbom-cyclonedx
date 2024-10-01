# frozen_string_literal: true
# rbs_inline: enabled

# Confidence Interval - The confidence interval of the metric.
module SBOM
  module Cyclonedx
    class ConfidenceInterval < SchemaObject
      # Lower Bound - The lower bound of the confidence interval.
      attr_accessor :lower_bound #: String

      # Upper Bound - The upper bound of the confidence interval.
      attr_accessor :upper_bound #: String
    end
  end
end
