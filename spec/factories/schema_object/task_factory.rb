# frozen_string_literal: true

FactoryBot.define do
  factory :task, parent: :schema_object, class: "SBOM::CycloneDX::Task" do
    trait :all_fields
  end
end
