# frozen_string_literal: true

FactoryBot.define do
  factory :service, parent: :schema_object, class: "SBOM::CycloneDX::Service" do
    trait :all_fields
  end
end
