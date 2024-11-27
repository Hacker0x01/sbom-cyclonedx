# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "base"
require_relative "property"
require_relative "risk"
require_relative "fairness_assessment"
require_relative "input_output_ml_parameter"
require_relative "performance_metric"
require_relative "graphics_collection"
require_relative "environmental_consideration"
require_relative "component_data"

# Model Card - A model card describes the intended uses of a machine learning model and potential limitations, including biases and ethical considerations. Model cards typically contain the training parameters, which datasets were used to train the model, performance metrics, and other relevant data useful for ML transparency. This object SHOULD be specified for any component of type `machine-learning-model` and must not be specified for other component types.
module SBOM
  module CycloneDX
    module Record
      # Schema name: ModelCard
      class ModelCard < Base
        # Schema name: Considerations
        class Considerations < Base
          # Users - Who are the intended users of the model?
          prop :users, :array, items: :string
          # Use Cases - What are the intended use cases of the model?
          prop :use_cases, :array, items: :string
          # Technical Limitations - What are the known technical limitations of the model? E.g. What kind(s) of data should the model be expected not to perform well on? What are the factors that might degrade model performance?
          prop :technical_limitations, :array, items: :string
          # Performance Tradeoffs - What are the known tradeoffs in accuracy/performance of the model?
          prop :performance_tradeoffs, :array, items: :string
          # Ethical Considerations - What are the ethical risks involved in the application of this model?
          prop :ethical_considerations, :array, items: Risk
          # Environmental Considerations - What are the various environmental impacts the corresponding machine learning model has exhibited across its lifecycle?
          prop :environmental_considerations, EnvironmentalConsideration
          # Fairness Assessments - How does the model affect groups at risk of being systematically disadvantaged? What are the harms and benefits to the various affected groups?
          prop :fairness_assessments, :array, items: FairnessAssessment
        end

        # Schema name: ModelParameters
        class ModelParameters < Base
          # Schema name: Approach
          class Approach < Base
            # Learning Type - Learning types describing the learning problem or hybrid learning problem.
            prop :type, :string, enum: Enum::LEARNING_TYPE
          end

          # Schema name: DataReference
          class DataReference < Base
            # Reference - References a data component by the components bom-ref attribute
            prop :ref, :string, pattern: Pattern::REF_OR_CDX_URN
          end

          # Approach - The overall approach to learning used by the model for problem solving.
          prop :approach, Approach
          # Task - Directly influences the input and/or output. Examples include classification, regression, clustering, etc.
          prop :task, :string
          # Architecture Family - The model architecture family such as transformer network, convolutional neural network, residual neural network, LSTM neural network, etc.
          prop :architecture_family, :string
          # Model Architecture - The specific architecture of the model such as GPT-1, ResNet-50, YOLOv3, etc.
          prop :model_architecture, :string
          # Datasets - The datasets used to train and evaluate the model.
          prop :datasets, :array, items: [:union, of: [ComponentData, DataReference]]
          # Inputs - The input format(s) of the model
          prop :inputs, :array, items: InputOutputMLParameter
          # Outputs - The output format(s) from the model
          prop :outputs, :array, items: InputOutputMLParameter
        end

        # Schema name: QuantitativeAnalysis
        class QuantitativeAnalysis < Base
          # Performance Metrics - The model performance metrics being reported. Examples may include accuracy, F1 score, precision, top-3 error rates, MSC, etc.
          prop :performance_metrics, :array, items: PerformanceMetric
          prop :graphics, GraphicsCollection
        end

        # BOM Reference - An optional identifier which can be used to reference the model card elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
        prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
        # Model Parameters - Hyper-parameters for construction of the model.
        prop :model_parameters, ModelParameters
        # Quantitative Analysis - A quantitative analysis of the model
        prop :quantitative_analysis, QuantitativeAnalysis
        # Considerations - What considerations should be taken into account regarding the model's construction, training, and application?
        prop :considerations, Considerations
        # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
        prop :properties, :array, items: Property
      end
    end
  end
end
