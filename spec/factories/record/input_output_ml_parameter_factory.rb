# frozen_string_literal: true

FactoryBot.define do
  factory :input_output_ml_parameter, parent: :record, class: "SBOM::CycloneDX::Record::InputOutputMLParameter" do
    trait :all_fields do
      format { %w[string image time-series].sample }
    end
  end
end
