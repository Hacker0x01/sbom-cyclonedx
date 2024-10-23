# frozen_string_literal: true

FactoryBot.define do
  factory :graphics_collection, parent: :schema_object, class: "SBOM::CycloneDX::GraphicsCollection" do
    trait :all_fields do
      description { Faker::Lorem.sentence }
      collection { association_list(:graphic) }
    end
  end
end
