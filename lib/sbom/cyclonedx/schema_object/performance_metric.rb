# frozen_string_literal: true
# rbs_inline: enabled

# Performance Metric
module SBOM
  module Cyclonedx
    class PerformanceMetric < SchemaObject
      # Type - The type of performance metric.
      attr_accessor :type #: String

      # Value - The value of the performance metric.
      attr_accessor :value #: String

      # Slice - The name of the slice this metric was computed on. By default, assume this metric is not sliced.
      attr_accessor :slice #: String

      # Confidence Interval - The confidence interval of the metric.
      attr_accessor :confidence_interval #: ConfidenceInterval
    end
  end
end
