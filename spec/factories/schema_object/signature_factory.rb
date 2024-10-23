# frozen_string_literal: true

FactoryBot.define do
  # This will almost not pass cursory validation, but is good enough for these specs
  factory :jsf_signature, parent: :schema_object, class: "SBOM::CycloneDX::Signature::JSFSignature" do
    algorithm { SBOM::CycloneDX::Enum::SIGNATURE_ALGORITHM.sample }
    value { Base64.encode64(SecureRandom.bytes(64)) }

    trait :all_fields do
      key_id { SecureRandom.uuid }
      public_key { generate_association(%i[ec okp rsa]) }
      certificate_path { Array.new(rand(1..3)) { Base64.encode64(SecureRandom.bytes(534)) } }
      excludes { Faker::Lorem.words(number: rand(1..3)).map(&:downcase) }
    end
  end

  factory :signature_chain, parent: :schema_object, class: "SBOM::CycloneDX::Signature::SignatureChain" do
    trait :all_fields do
      signatures { association_list(:jsf_signature) }
    end
  end

  factory :signer_list, parent: :schema_object, class: "SBOM::CycloneDX::Signature::SignerList" do
    trait :all_fields do
      signers { association_list(:jsf_signature) }
    end
  end

  factory :ec, parent: :schema_object, class: "SBOM::CycloneDX::Signature::JSFSignature::PublicKey::EC" do
    crv { SBOM::CycloneDX::Enum::SIGNATURE_EC_CRV.sample }
    x { Base64.encode64(SecureRandom.bytes(32)) }
    y { Base64.encode64(SecureRandom.bytes(32)) }

    trait :all_fields
  end

  factory :okp, parent: :schema_object, class: "SBOM::CycloneDX::Signature::JSFSignature::PublicKey::OKP" do
    crv { SBOM::CycloneDX::Enum::SIGNATURE_OKP_CRV.sample }
    x { Base64.encode64(SecureRandom.bytes(32)) }

    trait :all_fields
  end

  factory :rsa, parent: :schema_object, class: "SBOM::CycloneDX::Signature::JSFSignature::PublicKey::RSA" do
    n { Base64.encode64(rand(1..4096).to_s) }
    e { Base64.encode64(rand(1..4096).to_s) }

    trait :all_fields
  end
end
