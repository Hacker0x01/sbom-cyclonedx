# frozen_string_literal: true

FactoryBot.define do
  factory :performance_metric, parent: :schema_object, class: "SBOM::CycloneDX::PerformanceMetric" do
    trait :all_fields
  end
end
