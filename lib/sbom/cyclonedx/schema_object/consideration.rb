# frozen_string_literal: true
# rbs_inline: enabled

# Considerations - What considerations should be taken into account regarding the model's construction, training, and application?
module SBOM
  module Cyclonedx
    class Consideration < SchemaObject
      # Users - Who are the intended users of the model?
      attr_accessor :users #: [String]

      # Use Cases - What are the intended use cases of the model?
      attr_accessor :use_cases #: [String]

      # Technical Limitations - What are the known technical limitations of the model? E.g. What kind(s) of data should the model be expected not to perform well on? What are the factors that might degrade model performance?
      attr_accessor :technical_limitations #: [String]

      # Performance Tradeoffs - What are the known tradeoffs in accuracy/performance of the model?
      attr_accessor :performance_tradeoffs #: [String]

      # Ethical Considerations - What are the ethical risks involved in the application of this model?
      attr_accessor :ethical_considerations #: [Risk]

      # Environmental Considerations - What are the various environmental impacts the corresponding machine learning model has exhibited across its lifecycle?
      attr_accessor :environmental_considerations #: EnvironmentalConsideration

      # Fairness Assessments - How does the model affect groups at risk of being systematically disadvantaged? What are the harms and benefits to the various affected groups?
      attr_accessor :fairness_assessments #: [FairnessAssessment]
    end
  end
end
