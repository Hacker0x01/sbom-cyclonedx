# frozen_string_literal: true

require_relative "base"

# Performance Metric
module SBOM
  module CycloneDX
    module Record
      # Schema name: PerformanceMetric
      class PerformanceMetric < Base
        # Schema name: ConfidenceInterval
        class ConfidenceInterval < Base
          # Lower Bound - The lower bound of the confidence interval.
          prop :lower_bound, :string
          # Upper Bound - The upper bound of the confidence interval.
          prop :upper_bound, :string
        end

        # Type - The type of performance metric.
        prop :type, :string
        # Value - The value of the performance metric.
        prop :value, :string
        # Slice - The name of the slice this metric was computed on. By default, assume this metric is not sliced.
        prop :slice, :string
        # Confidence Interval - The confidence interval of the metric.
        prop :confidence_interval, ConfidenceInterval
      end
    end
  end
end
