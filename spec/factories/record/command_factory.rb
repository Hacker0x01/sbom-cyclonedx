# frozen_string_literal: true

FactoryBot.define do
  factory :command, parent: :record, class: "SBOM::CycloneDX::Record::Command" do
    trait :all_fields do
      executed { "echo '#{Faker::Lorem.sentence}'" }
      properties { association_list(:property) }
    end
  end
end
