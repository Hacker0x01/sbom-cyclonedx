# frozen_string_literal: true

FactoryBot.define do
  factory :commit, parent: :record, class: "SBOM::CycloneDX::Record::Commit" do
    trait :all_fields do
      uid { Faker::Crypto.sha1 }
      url { generate(:url) }
      author factory: :identifiable_action
      committer factory: :identifiable_action
      message { Faker::Lorem.sentence }
    end
  end
end
