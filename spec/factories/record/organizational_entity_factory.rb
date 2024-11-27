# frozen_string_literal: true

FactoryBot.define do
  factory :organizational_entity, parent: :record, class: "SBOM::CycloneDX::Record::OrganizationalEntity" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      name { Faker::Company.name }
      address { association(:postal_address) }
      url { [Faker::Internet.url] }
      contact { association_list(:organizational_contact) }
    end
  end
end
