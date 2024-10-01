# frozen_string_literal: true
# rbs_inline: enabled

# Model Parameters - Hyper-parameters for construction of the model.
module SBOM
  module Cyclonedx
    class ModelParameter < SchemaObject
      # Approach - The overall approach to learning used by the model for problem solving.
      attr_accessor :approach #: Approach

      # Task - Directly influences the input and/or output. Examples include classification, regression, clustering, etc.
      attr_accessor :task #: String

      # Architecture Family - The model architecture family such as transformer network, convolutional neural network, residual neural network, LSTM neural network, etc.
      attr_accessor :architecture_family #: String

      # Model Architecture - The specific architecture of the model such as GPT-1, ResNet-50, YOLOv3, etc.
      attr_accessor :model_architecture #: String

      # Datasets - The datasets used to train and evaluate the model.
      attr_accessor :datasets #: [ComponentData | DataReference]

      # Inputs - The input format(s) of the model
      attr_accessor :inputs #: [InputOutputMlParameter]

      # Outputs - The output format(s) from the model
      attr_accessor :outputs #: [InputOutputMlParameter]
    end
  end
end
