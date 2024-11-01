# frozen_string_literal: true

FactoryBot.define do
  factory :organizational_entity, parent: :schema_object, class: "SBOM::CycloneDX::OrganizationalEntity" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      name { Faker::Company.name }
      address { association(:postal_address) }
      url { [Faker::Internet.url] }
      contact { association_list(:organizational_contact) }
    end
  end
end
