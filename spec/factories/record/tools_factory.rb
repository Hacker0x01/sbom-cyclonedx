# frozen_string_literal: true

FactoryBot.define do
  factory :tools, parent: :record, class: "SBOM::CycloneDX::Record::Tools" do
    trait :all_fields do
      components { association_list(:component) }
      services { association_list(:service) }
    end
  end
end
