# frozen_string_literal: true
# rbs_inline: enabled

# Model Card - A model card describes the intended uses of a machine learning model and potential limitations, including biases and ethical considerations. Model cards typically contain the training parameters, which datasets were used to train the model, performance metrics, and other relevant data useful for ML transparency. This object SHOULD be specified for any component of type `machine-learning-model` and must not be specified for other component types.
module Sbom
  module Cyclonedx
    class ModelCard < SchemaObject
      # BOM Reference - An optional identifier which can be used to reference the model card elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.
      attr_accessor :bom_ref #: RefLink

      # Model Parameters - Hyper-parameters for construction of the model.
      attr_accessor :model_parameters #: ModelParameter

      # Quantitative Analysis - A quantitative analysis of the model
      attr_accessor :quantitative_analysis #: QuantitativeAnalysis

      # Considerations - What considerations should be taken into account regarding the model's construction, training, and application?
      attr_accessor :considerations #: Consideration

      # Properties - Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy). Formal registration is optional.
      attr_accessor :properties #: [Property]
    end
  end
end
