# frozen_string_literal: true

FactoryBot.define do
  factory :organizational_entity, parent: :schema_object, class: "SBOM::CycloneDX::OrganizationalEntity" do
    trait :all_fields
  end
end
