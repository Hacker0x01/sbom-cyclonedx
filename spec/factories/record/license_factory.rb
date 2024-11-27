# frozen_string_literal: true

FactoryBot.define do
  factory :license, parent: :record, class: "SBOM::CycloneDX::Record::License" do
    transient do
      license_specifier { %i[id name].sample }
    end

    trait :id do
      license_specifier { :id }
    end

    trait :name do
      license_specifier { :name }
    end

    id { license_specifier == :id ? SBOM::CycloneDX::Enum::LICENSE_ID.sample : nil }
    name { license_specifier == :name ? Faker::Lorem.word : nil }

    trait :all_fields do
      bom_ref { generate(:ref_link) }
      acknowledgement { SBOM::CycloneDX::Enum::LICENSE_ACKNOWLEDGEMENT.sample }
      text { association(:attachment) }
      url { generate(:url) }
      licensing { association(:licensing) }
      properties { association_list(:property) }
    end
  end

  factory :licensing, parent: :record, class: "SBOM::CycloneDX::Record::License::Licensing" do
    trait :all_fields do
      alt_ids { Array.new(rand(1..3)) { Faker::Lorem.word } }
      licensor { association(:licensor) }
      licensee { association(:licensee) }
      purchaser { association(:purchaser) }
      purchase_order { Faker::Lorem.word }
      license_types { Array.new(rand(1..3)) { SBOM::CycloneDX::Enum::LICENSE_TYPE.sample } }
      last_renewal { Faker::Time.backward(days: 367) }
      expiration { last_renewal + rand(1..730).days }
    end
  end

  factory :licensor, parent: :record, class: "SBOM::CycloneDX::Record::License::Licensing::Licensor" do
    transient do
      licensor_type { %i[organization individual] }
    end

    trait :organization do
      licensor_type { :organization }
    end

    trait :individual do
      licensor_type { :individual }
    end

    organization { licensor_type == :organization ? association(:organizational_entity) : nil }
    individual { licensor_type == :individual ? association(:organizational_contact) : nil }

    trait :all_fields
  end

  factory :licensee, parent: :record, class: "SBOM::CycloneDX::Record::License::Licensing::Licensee" do
    transient do
      licensee_type { %i[organization individual] }
    end

    trait :organization do
      licensee_type { :organization }
    end

    trait :individual do
      licensee_type { :individual }
    end

    organization { licensee_type == :organization ? association(:organizational_entity) : nil }
    individual { licensee_type == :individual ? association(:organizational_contact) : nil }

    trait :all_fields
  end

  factory :purchaser, parent: :record, class: "SBOM::CycloneDX::Record::License::Licensing::Purchaser" do
    transient do
      purchaser_type { %i[organization individual] }
    end

    trait :organization do
      purchaser_type { :organization }
    end

    trait :individual do
      purchaser_type { :individual }
    end

    organization { purchaser_type == :organization ? association(:organizational_entity) : nil }
    individual { purchaser_type == :individual ? association(:organizational_contact) : nil }

    trait :all_fields
  end
end
