# frozen_string_literal: true

FactoryBot.define do
  factory :trigger, parent: :schema_object, class: "SBOM::CycloneDX::Trigger" do
    bom_ref { generate(:ref_link) }
    uid { Faker::Lorem.characters(number: 16) }
    type { SBOM::CycloneDX::Enum::TRIGGER_TYPE.sample }

    trait :all_fields do
      name { Faker::Lorem.word }
      description { Faker::Lorem.sentence }
      resource_references { association_list(:resource_reference_choice) }
      event { association(:event) }
      conditions { association_list(:condition) }
      time_activated { Faker::Time.backward(days: 367) }
      inputs { association_list(:input) }
      outputs { association_list(:output) }
      properties { association_list(:property) }
    end
  end
end
