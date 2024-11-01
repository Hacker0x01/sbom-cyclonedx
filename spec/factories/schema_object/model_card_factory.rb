# frozen_string_literal: true

FactoryBot.define do
  factory :model_card, parent: :schema_object, class: "SBOM::CycloneDX::ModelCard" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      model_parameters { association(:model_parameters) }
      quantitative_analysis { association(:quantitative_analysis) }
      considerations { association(:considerations) }
      properties { association_list(:property) }
    end
  end

  factory :considerations, parent: :schema_object, class: "SBOM::CycloneDX::ModelCard::Considerations" do
    trait :all_fields do
      users { Array.new(rand(1..3)) { Faker::Lorem.word } }
      use_cases { Array.new(rand(1..3)) { Faker::Lorem.word } }
      technical_limitations { Array.new(rand(1..3)) { Faker::Lorem.word } }
      performance_tradeoffs { Array.new(rand(1..3)) { Faker::Lorem.word } }
      ethical_considerations { association_list(:risk) }
      environmental_considerations { association(:environmental_consideration) }
      fairness_assessments { association_list(:fairness_assessment) }
    end
  end

  factory :model_parameters, parent: :schema_object, class: "SBOM::CycloneDX::ModelCard::ModelParameters" do
    trait :all_fields do
      approach { association(:approach) }
      task { Faker::Lorem.word }
      architecture_family { Faker::Lorem.word }
      model_architecture { Faker::Lorem.word }
      datasets do
        Array.new(1..3) { Faker::Boolean.boolean ? association(:component_data) : association(:data_reference) }
      end
      inputs { association_list(:input_output_ml_parameter) }
      outputs { association_list(:input_output_ml_parameter) }
    end
  end

  factory :approach, parent: :schema_object, class: "SBOM::CycloneDX::ModelCard::ModelParameters::Approach" do
    trait :all_fields do
      type { SBOM::CycloneDX::Enum::LEARNING_TYPE.sample }
    end
  end

  factory :data_reference, parent: :schema_object,
                           class: "SBOM::CycloneDX::ModelCard::ModelParameters::DataReference" do
    trait :all_fields do
      ref { generate(:ref_or_cdx_urn) }
    end
  end

  factory :quantitative_analysis, parent: :schema_object, class: "SBOM::CycloneDX::ModelCard::QuantitativeAnalysis" do
    trait :all_fields do
      performance_metrics { association_list(:performance_metric) }
      graphics { association(:graphics_collection) }
    end
  end
end
