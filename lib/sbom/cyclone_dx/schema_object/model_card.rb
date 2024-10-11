# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Model Card - A model card describes the intended uses of a machine learning model and potential limitations, including biases and ethical considerations. Model cards typically contain the training parameters, which datasets were used to train the model, performance metrics, and other relevant data useful for ML transparency. This object SHOULD be specified for any component of type `machine-learning-model` and must not be specified for other component types.
module SBOM
  module CycloneDX
    class ModelCard < Struct.new(
      "ModelCard",
      # BOM Reference - An optional identifier which can be used to reference the model card elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      :bom_ref,
      # Model Parameters - Hyper-parameters for construction of the model.
      :model_parameters,
      # Quantitative Analysis - A quantitative analysis of the model
      :quantitative_analysis,
      # Considerations - What considerations should be taken into account regarding the model's construction, training, and application?
      :considerations,
      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      :properties,
      keyword_init: true
    )
      include SchemaObject

      json_name :bom_ref, "bom-ref"

      def valid?
        Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
          Validator.valid?(ModelParameters, model_parameters) &&
          Validator.valid?(QuantitativeAnalysis, quantitative_analysis) &&
          Validator.valid?(Consideration, considerations) &&
          Validator.valid?(Array, properties, items: Property)
      end

      class Consideration < Struct.new(
        "Consideration",
        # Users - Who are the intended users of the model?
        :users,
        # Use Cases - What are the intended use cases of the model?
        :use_cases,
        # Technical Limitations - What are the known technical limitations of the model? E.g. What kind(s) of data should the model be expected not to perform well on? What are the factors that might degrade model performance?
        :technical_limitations,
        # Performance Tradeoffs - What are the known tradeoffs in accuracy/performance of the model?
        :performance_tradeoffs,
        # Ethical Considerations - What are the ethical risks involved in the application of this model?
        :ethical_considerations,
        # Environmental Considerations - What are the various environmental impacts the corresponding machine learning model has exhibited across its lifecycle?
        :environmental_considerations,
        # Fairness Assessments - How does the model affect groups at risk of being systematically disadvantaged? What are the harms and benefits to the various affected groups?
        :fairness_assessments,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(Array, users, items: String) &&
            Validator.valid?(Array, use_cases, items: String) &&
            Validator.valid?(Array, technical_limitations, items: String) &&
            Validator.valid?(Array, performance_tradeoffs, items: String) &&
            Validator.valid?(Array, ethical_considerations, items: Risk) &&
            Validator.valid?(EnvironmentalConsideration, environmental_considerations) &&
            Validator.valid?(Array, fairness_assessments, items: FairnessAssessment)
        end
      end

      class ModelParameters < Struct.new(
        "ModelParameters",
        # Approach - The overall approach to learning used by the model for problem solving.
        :approach,
        # Task - Directly influences the input and/or output. Examples include classification, regression, clustering, etc.
        :task,
        # Architecture Family - The model architecture family such as transformer network, convolutional neural network, residual neural network, LSTM neural network, etc.
        :architecture_family,
        # Model Architecture - The specific architecture of the model such as GPT-1, ResNet-50, YOLOv3, etc.
        :model_architecture,
        # Datasets - The datasets used to train and evaluate the model.
        :datasets,
        # Inputs - The input format(s) of the model
        :inputs,
        # Outputs - The output format(s) from the model
        :outputs,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(Approach, approach) &&
            Validator.valid?(String, task) &&
            Validator.valid?(String, architecture_family) &&
            Validator.valid?(String, model_architecture) &&
            Validator.valid?(Array, datasets, items: [Union, klasses: [ComponentData, DataReference]]) &&
            Validator.valid?(Array, inputs, items: InputOutputMLParameter) &&
            Validator.valid?(Array, outputs, items: InputOutputMLParameter)
        end

        class Approach < Struct.new(
          "Approach",
          # Learning Type - Learning types describing the learning problem or hybrid learning problem.
          :type,
          keyword_init: true
        )
          include SchemaObject

          def valid?
            Validator.valid?(String, type, enum: Enum::LEARNING_TYPE)
          end
        end

        class DataReference < Struct.new(
          "DataReference",
          # Reference - References a data component by the components bom-ref attribute
          :ref,
          keyword_init: true
        )
          include SchemaObject

          def valid?
            Validator.valid?(String, ref, pattern: Pattern::REF_LINK_OR_BOM_LINK_ELEMENT)
          end
        end
      end

      class QuantitativeAnalysis < Struct.new(
        "QuantitativeAnalysis",
        # Performance Metrics - The model performance metrics being reported. Examples may include accuracy, F1 score, precision, top-3 error rates, MSC, etc.
        :performance_metrics,
        :graphics,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(Array, performance_metrics, items: PerformanceMetric) &&
            Validator.valid?(GraphicsCollection, graphics)
        end
      end
    end
  end
end
