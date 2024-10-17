# frozen_string_literal: true

FactoryBot.define do
  factory :commit, parent: :schema_object, class: "SBOM::CycloneDX::Commit" do
    trait :all_fields do
      uid { Faker::Crypto.sha1 }
      url { generate(:url) }
      author factory: :identifiable_action
      committer factory: :identifiable_action
      message { Faker::Lorem.sentence }
    end
  end
end
