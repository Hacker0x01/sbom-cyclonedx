# frozen_string_literal: true

FactoryBot.define do
  factory :signature, parent: :schema_object, class: "SBOM::CycloneDX::Signature" do
    initialize_with do
      [
        SBOM::CycloneDX::Signature::JSFSignature,
        SBOM::CycloneDX::Signature::SignatureChain,
        SBOM::CycloneDX::Signature::SignerList
      ].sample.new(**attributes)
    end

    trait :all_fields
  end
end
