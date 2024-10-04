# frozen_string_literal: true
# rbs_inline: enabled

# Performance Metric
module SBOM
  module CycloneDX
    PerformanceMetric = SchemaObject.build("PerformanceMetric") do
      # Type - The type of performance metric.
      prop :type, String

      # Value - The value of the performance metric.
      prop :value, String

      # Slice - The name of the slice this metric was computed on. By default, assume this metric is not sliced.
      prop :slice, String

      # Confidence Interval - The confidence interval of the metric.
      prop :confidence_interval, ConfidenceInterval

      ConfidenceInterval = SchemaObject.build("ConfidenceInterval") do
        # Lower Bound - The lower bound of the confidence interval.
        prop :lower_bound, String

        # Upper Bound - The upper bound of the confidence interval.
        prop :upper_bound, String
      end
    end
  end
end
