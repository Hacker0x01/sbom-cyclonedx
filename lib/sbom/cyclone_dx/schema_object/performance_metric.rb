# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Performance Metric
module SBOM
  module CycloneDX
    class PerformanceMetric < Struct.new(
      "PerformanceMetric",
      # Type - The type of performance metric.
      :type,
      # Value - The value of the performance metric.
      :value,
      # Slice - The name of the slice this metric was computed on. By default, assume this metric is not sliced.
      :slice,
      # Confidence Interval - The confidence interval of the metric.
      :confidence_interval,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, type) &&
          Validator.valid?(String, value) &&
          Validator.valid?(String, slice) &&
          Validator.valid?(ConfidenceInterval, confidence_interval)
      end

      class ConfidenceInterval < Struct.new(
        "ConfidenceInterval",
        # Lower Bound - The lower bound of the confidence interval.
        :lower_bound,
        # Upper Bound - The upper bound of the confidence interval.
        :upper_bound,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(String, lower_bound) &&
            Validator.valid?(String, upper_bound)
        end
      end
    end
  end
end
