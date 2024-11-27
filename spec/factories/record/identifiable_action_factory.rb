# frozen_string_literal: true

FactoryBot.define do
  factory :identifiable_action, parent: :record, class: "SBOM::CycloneDX::Record::IdentifiableAction" do
    trait :all_fields do
      timestamp { Faker::Time.backward(days: 367) }
      name { Faker::Lorem.word }
      email { generate(:email) }
    end
  end
end
