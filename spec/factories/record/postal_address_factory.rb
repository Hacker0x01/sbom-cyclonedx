# frozen_string_literal: true

FactoryBot.define do
  factory :postal_address, parent: :record, class: "SBOM::CycloneDX::Record::PostalAddress" do
    trait :all_fields do
      country { Faker::Address.country }
      region { Faker::Address.state }
      locality { Faker::Address.city }
      post_office_box_number { Faker::Address.building_number }
      postal_code { Faker::Address.zip_code }
      street_address { Faker::Address.street_address }
    end
  end
end
