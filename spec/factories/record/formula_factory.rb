# frozen_string_literal: true

FactoryBot.define do
  factory :formula, parent: :record, class: "SBOM::CycloneDX::Record::Formula" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      components { association_list(:component) }
      services { association_list(:service) }
      workflows { association_list(:workflow) }
      properties { association_list(:property) }
    end
  end
end
