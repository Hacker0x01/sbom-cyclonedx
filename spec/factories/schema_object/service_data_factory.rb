# frozen_string_literal: true

FactoryBot.define do
  factory :service_data, parent: :schema_object, class: "SBOM::CycloneDX::ServiceData" do
    trait :all_fields
  end
end
