# frozen_string_literal: true

FactoryBot.define do
  factory :definitions, parent: :record, class: "SBOM::CycloneDX::Record::Definitions" do
    trait :all_fields do
      standards { association_list(:standard) }
    end
  end
end
