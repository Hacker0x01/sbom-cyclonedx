# frozen_string_literal: true

FactoryBot.define do
  factory :crypto_properties, parent: :record, class: "SBOM::CycloneDX::Record::CryptoProperties" do
    asset_type { SBOM::CycloneDX::Enum::ASSET_TYPE.sample }

    trait :all_fields do
      algorithm_properties { association :algorithm_properties }
      certificate_properties { association :certificate_properties }
      related_crypto_material_properties { association :related_crypto_material_properties }
      protocol_properties { association :protocol_properties }
      oid do
        # Pseudo-random sample of crypto-related OIDs of different lengths in different forms
        [
          "1.2",
          "iso.member-body",
          "1.3.132",
          "iso.identified-organization.certicom",
          "2.5.29.17",
          "joint-iso-itu-t.ds.certificateExtension.subjectAltName",
          "1.3.132.0.23",
          "iso.identified-organization.certicom.curve.sect131r2",
          "1.3.132.1.14.3",
          "iso.identified-organization.certicom.schemes.14.dhSinglePass-cofactorDH-sha512kdf-scheme",
          "1.2.840.113549.1.9.5",
          "iso.member-body.us.rsadsi.pkcs.pkcs-9.signing-time",
          "1.3.6.1.1.1.2.8",
          "iso.identified-organization.dod.internet.directory.nisSchema.2.nisNetgroup",
          "1.3.6.1.5.5.7.4.11",
          "iso.identified-organization.dod.internet.security.mechanisms.pkix.it.id-it-keyPairParamRep",
          "1.3.6.1.4.1.311.12.1.2",
          "iso.identified-organization.dod.internet.private.enterprise.311 12 1 2",
          "1.3.6.1.4.1.1722.12.2.1.16",
          "iso.identified-organization.dod.internet.private.enterprise.1722 cryptography.hashAlgs.blake2b.16",
          "1.3.6.1.4.1.42.2.27.2.1.15",
          "iso.identified-organization.dod.internet.private.enterprise.42 products.27 2 1 rfc822MailMember",
          "1.2.804.2.1.1.1.1.3.1.1.2.3",
          "iso.member-body.ua.root.security.cryptography.ua-pki.alg.asym.dstu4145WithGost34311." \
          "dstu4145WithGost34311-pb.dstu4145WithGost34311keyFormat-PB.dstu4145WithGost34311m179-PB"
        ].sample
      end
    end
  end

  factory(
    :algorithm_properties,
    parent: :record,
    class: "SBOM::CycloneDX::Record::CryptoProperties::AlgorithmProperties"
  ) do
    trait :all_fields do
      primitive { SBOM::CycloneDX::Enum::PRIMITIVE.sample }
      parameter_set_identifier { %w[128 256 512].sample }
      curve do
        [
          "FRP256v1",
          "BLS12-477",
          "Bandersnatch",
          "bn638",
          "brainpoolP512t1",
          "gost512",
          "id-tc26-gost-3410-12-512-paramSetB",
          "id-GostR3410-2001-CryptoPro-C-ParamSet",
          "mnt4",
          "mnt5/1",
          "B-409",
          "numsp512t1",
          "ed-511-mers",
          "w-510-mont",
          "Oakley Group 4",
          "384-bit Random ECP Group",
          "SM2",
          "Curve22103",
          "Ed448-Goldilocks",
          "Fp254n2BNa",
          "ssc-512",
          "Tweedledum",
          "Tweedledee",
          "JubJub",
          "Vesta",
          "BADA55-VPR-224",
          "Tom-521",
          "sect571k1",
          "wap-wsg-idm-ecid-wtls12",
          "prime239v3",
          "c2pnb163v1",
          "ansit233r1"
        ].sample
      end
      execution_environment { SBOM::CycloneDX::Enum::EXECUTION_ENVIRONMENT.sample }
      implementation_platform { SBOM::CycloneDX::Enum::IMPLEMENTATION_PLATFORM.sample }
      certification_level { Array.new(rand(1..3)) { SBOM::CycloneDX::Enum::CERTIFICATION_LEVEL.sample } }
      mode { SBOM::CycloneDX::Enum::ALGORITHM_MODE.sample }
      padding { SBOM::CycloneDX::Enum::PADDING.sample }
      crypto_functions { Array.new(rand(1..3)) { SBOM::CycloneDX::Enum::CRYPTO_FUNCTION.sample } }
      classical_security_level do
        base_power = 2**rand(7..12)
        next base_power if Faker::Boolean.boolean

        base_power + (2**rand(3..9))
      end
      nist_quantum_security_level do
        # Not how this is actually calculated. Just ensuring the values roughly correlate
        Math.log2(classical_security_level).floor - 6
      end
    end
  end

  factory(
    :certificate_properties,
    parent: :record,
    class: "SBOM::CycloneDX::Record::CryptoProperties::CertificateProperties"
  ) do
    trait :all_fields do
      subject_name { Faker::Internet.domain_name }
      issuer_name do
        [
          "ACCVRAIZ1",
          "Certum Trusted Root CA",
          "DigiCert SMIME ECC P384 Root G5",
          "ePKI Root Certification Authority",
          "GlobalSign",
          "GTS Root R1",
          "IdenTrust Commercial Root CA 1",
          "ISRG Root X2",
          "OISTE WISeKey Global Root GB CA",
          "Starfield Class 2 Certification Authority",
          "SZAFIR ROOT CA2",
          "TeliaSonera Root CA v1",
          "Trustwave Global Certification Authority",
          "Trustwave Global ECC P256 Certification Authority",
          "vTrus ECC Root CA",
          "XRamp Global Certification Authority"
        ].sample
      end
      not_valid_before { Faker::Time.between(from: 730.days.ago, to: 183.days.from_now) }
      not_valid_after { not_valid_before + rand(1..913).days }
      signature_algorithm_ref { generate(:ref_link) }
      subject_public_key_ref { generate(:ref_link) }
      certificate_format { %w[X.509 PEM DER CVC].sample }
      certificate_extension { %w[crt pem cer der p12].sample }
    end
  end

  factory(
    :protocol_properties,
    parent: :record,
    class: "SBOM::CycloneDX::Record::CryptoProperties::ProtocolProperties"
  ) do
    trait :all_fields do
      type { SBOM::CycloneDX::Enum::PROTOCOL_TYPE.sample }
      version { Faker::App.version }
      cipher_suites { association_list(:cipher_suite) }
      ikev2_transform_types { association :ikev2_transform_type }
      crypto_ref_array { Array.new(rand(1..3)) { generate(:ref_link) } }
    end
  end

  factory(
    :ikev2_transform_type,
    parent: :record,
    class: "SBOM::CycloneDX::Record::CryptoProperties::ProtocolProperties::IKEv2TransformType"
  ) do
    trait :all_fields do
      encr { Array.new(rand(1..3)) { generate(:ref_link) } }
      prf { Array.new(rand(1..3)) { generate(:ref_link) } }
      integ { Array.new(rand(1..3)) { generate(:ref_link) } }
      ke { Array.new(rand(1..3)) { generate(:ref_link) } }
      esn { Array.new(rand(1..3)) { generate(:ref_link) } }
      auth { Array.new(rand(1..3)) { generate(:ref_link) } }
    end
  end

  factory(
    :related_crypto_material_properties,
    class: "SBOM::CycloneDX::Record::CryptoProperties::RelatedCryptoMaterialProperties"
  ) do
    trait :all_fields do
      type { SBOM::CycloneDX::Enum::RELATED_CRYPTO_MATERIAL_TYPE.sample }
      id { SecureRandom.uuid }
      state { SBOM::CycloneDX::Enum::RELATED_CRYPTO_MATERIAL_STATE.sample }
      creation_date { Faker::Time.backward(days: 367) }
      activation_date { creation_date + rand(1..183).days }
      update_date { activation_date + rand(1..183).days }
      expiration_date { update_date + rand(1..367).days }
      value { Faker::Crypto.md5 }
      asset_size { rand(1..(2**16)) }
      format { %w[P8 PEM DER CVC].sample }
      secured_by { association_list(:secured_by) }
    end
  end
end
