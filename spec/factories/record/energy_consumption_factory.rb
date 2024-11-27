# frozen_string_literal: true

FactoryBot.define do
  factory :energy_consumption, parent: :record, class: "SBOM::CycloneDX::Record::EnergyConsumption" do
    activity { SBOM::CycloneDX::Enum::ACTIVITY.sample }
    energy_providers { association_list(:energy_provider) }
    activity_energy_cost { association(:energy_measure) }

    trait :all_fields do
      co2_cost_equivalent { association(:co2_measure) }
      co2_cost_offset { association(:co2_measure) }
      properties { association_list(:property) }
    end
  end
end
