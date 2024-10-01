# frozen_string_literal: true
# rbs_inline: enabled

# Quantitative Analysis - A quantitative analysis of the model
module SBOM
  module Cyclonedx
    class QuantitativeAnalysis < SchemaObject
      # Performance Metrics - The model performance metrics being reported. Examples may include accuracy, F1 score, precision, top-3 error rates, MSC, etc.
      attr_accessor :performance_metrics #: [PerformanceMetric]

      attr_accessor :graphics #: GraphicsCollection
    end
  end
end
