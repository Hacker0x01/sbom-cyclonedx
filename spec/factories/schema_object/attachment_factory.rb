# frozen_string_literal: true

FactoryBot.define do
  factory :attachment, parent: :schema_object, class: "SBOM::CycloneDX::Attachment" do
    content { Base64.encode64(Faker::Lorem.paragraph) }
  end

  trait :all_fields
end
