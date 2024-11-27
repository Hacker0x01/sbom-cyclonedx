# frozen_string_literal: true

FactoryBot.define do
  factory :metadata, parent: :record, class: "SBOM::CycloneDX::Record::Metadata" do
    trait :all_fields do
      timestamp { Faker::Time.backward(days: 4) }
      lifecycles do
        Array.new(rand(1..3)) do
          next association(:pre_defined_phase) if Faker::Boolean.boolean

          association(:custom_phase)
        end
      end
      tools { association(:tools) }
      manufacturer { association(:organizational_entity) }
      authors { association_list(:organizational_contact) }
      component { association(:component) }
      manufacture { association(:organizational_entity) }
      supplier { association(:organizational_entity) }
      licenses { license_choice_list }
      properties { association_list(:property) }
    end
  end

  factory :custom_phase, parent: :record, class: "SBOM::CycloneDX::Record::Metadata::CustomPhase" do
    name { Faker::Lorem.word }

    trait :all_fields do
      description { Faker::Lorem.sentence }
    end
  end

  factory :pre_defined_phase, parent: :record, class: "SBOM::CycloneDX::Record::Metadata::PreDefinedPhase" do
    phase { SBOM::CycloneDX::Enum::PHASE.sample }

    trait :all_fields
  end
end
