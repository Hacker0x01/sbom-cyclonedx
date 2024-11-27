# frozen_string_literal: true

FactoryBot.define do
  factory :patch, parent: :record, class: "SBOM::CycloneDX::Record::Patch" do
    type { SBOM::CycloneDX::Enum::PATCH_TYPE.sample }

    trait :all_fields do
      diff { association(:diff) }
      resolves { association_list(:issue) }
    end
  end
end
