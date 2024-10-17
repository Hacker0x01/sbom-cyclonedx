# frozen_string_literal: true

FactoryBot.define do
  factory :command, parent: :schema_object, class: "SBOM::CycloneDX::Command" do
    trait :all_fields do
      executed { "echo '#{Faker::Lorem.sentence}'" }
      properties { build_list(:property, rand(0..4), :all_fields) }
    end
  end
end
