# frozen_string_literal: true

FactoryBot.define do
  factory :organizational_contact, parent: :record, class: "SBOM::CycloneDX::Record::OrganizationalContact" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      name { Faker::Name.name }
      email { generate(:email) }
      phone { Faker::PhoneNumber.phone_number }
    end
  end
end
