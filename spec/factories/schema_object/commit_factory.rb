# frozen_string_literal: true

FactoryBot.define do
  factory :commit, parent: :schema_object, class: "SBOM::CycloneDX::Commit" do
    trait :all_fields do
      uid { Faker::Crypto.sha1 }
      url { generate(:url) }
      author { association(:identifiable_action, :all_fields) }
      committer { association(:identifiable_action, :all_fields) }
      message { Faker::Lorem.sentence }
    end
  end
end
