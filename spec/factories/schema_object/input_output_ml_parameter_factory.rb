# frozen_string_literal: true

FactoryBot.define do
  factory :input_output_ml_parameter, parent: :schema_object, class: "SBOM::CycloneDX::InputOutputMlParameter" do
    trait :all_fields
  end
end
