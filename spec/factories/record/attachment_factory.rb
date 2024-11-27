# frozen_string_literal: true

FactoryBot.define do
  factory :attachment, parent: :record, class: "SBOM::CycloneDX::Record::Attachment" do
    content { Base64.encode64(Faker::Lorem.paragraph) }
  end

  trait :all_fields
end
