# frozen_string_literal: true

FactoryBot.define do
  factory :input_output_ml_parameter, parent: :schema_object, class: "SBOM::CycloneDX::InputOutputMLParameter" do
    trait :all_fields do
      format { %w[string image time-series].sample }
    end
  end
end
