# frozen_string_literal: true

FactoryBot.define do
  factory :formula, parent: :schema_object, class: "SBOM::CycloneDX::Formula" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      components { association_list(:component) }
      services { association_list(:service) }
      workflows { association_list(:workflow) }
      properties { association_list(:property) }
    end
  end
end
