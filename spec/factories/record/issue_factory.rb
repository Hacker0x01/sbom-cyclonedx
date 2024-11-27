# frozen_string_literal: true

FactoryBot.define do
  factory :issue, parent: :record, class: "SBOM::CycloneDX::Record::Issue" do
    type { SBOM::CycloneDX::Enum::ISSUE_TYPE.sample }

    trait :all_fields do
      id { SecureRandom.uuid }
      name { Faker::Lorem.word }
      description { Faker::Lorem.sentence }
      source { association(:source) }
      references { Array.new(rand(1..3)) { generate(:url) } }
    end
  end

  factory :source, parent: :record, class: "SBOM::CycloneDX::Record::Issue::Source" do
    trait :all_fields do
      name { Faker::Lorem.word }
      url { generate(:url) }
    end
  end
end
