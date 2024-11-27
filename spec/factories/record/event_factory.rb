# frozen_string_literal: true

FactoryBot.define do
  factory :event, parent: :record, class: "SBOM::CycloneDX::Record::Event" do
    trait :all_fields do
      uid { SecureRandom.uuid }
      description { Faker::Lorem.sentence }
      time_received { Faker::Time.backward(days: 21) }
      data { association(:attachment) }
      source { association(:resource_reference_choice) }
      target { association(:resource_reference_choice) }
      properties { association_list(:property) }
    end
  end
end
