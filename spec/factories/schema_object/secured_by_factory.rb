# frozen_string_literal: true

FactoryBot.define do
  factory :secured_by, parent: :schema_object, class: "SBOM::CycloneDX::SecuredBy" do
    trait :all_fields
  end
end
