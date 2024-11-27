# frozen_string_literal: true

FactoryBot.define do
  factory :energy_provider, parent: :record, class: "SBOM::CycloneDX::Record::EnergyProvider" do
    organization { association(:organizational_entity) }
    energy_source { SBOM::CycloneDX::Enum::ENERGY_SOURCE.sample }
    energy_provided { association(:energy_measure) }

    trait :all_fields do
      bom_ref { generate(:ref_link) }
      description { Faker::Lorem.sentence }
      external_references { association_list(:external_reference) }
    end
  end
end
