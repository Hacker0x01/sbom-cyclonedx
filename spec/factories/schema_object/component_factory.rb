# frozen_string_literal: true

require "sbom/cyclone_dx/enum"

FactoryBot.define do
  factory :component, parent: :schema_object, class: "SBOM::CycloneDX::Component" do
    type { SBOM::CycloneDX::Enum::COMPONENT_TYPE.sample }
    name { Faker::Lorem.word }

    trait :all_fields do
      mime_type { generate(:mime_type) }
      bom_ref { generate(:ref_link) }
      supplier { association(:organizational_entity, :all_fields) }
      manufacturer { association(:organizational_entity, :all_fields) }
      authors { Array.new(rand(1..4)) { association(:organizational_contact, :all_fields) } }
      publisher { Faker::Lorem.word }
      group { Faker::Lorem.word }
      version { Faker::App.semantic_version }
      description { Faker::Lorem.sentence }
      scope { SBOM::CycloneDX::Enum::SCOPE.sample }
      hashes { association(:hash_data, :all_fields) }
      licenses { Array.new(rand(1..4)) { association(%i[license_expression wrapped_license].sample, :all_fields) } }
      copyright { Faker::Company.name }
      cpe do
        # cpe:2.3:part:vendor:product:version:update:edition:language:sw_edition:target_sw:target_hw:other
        "cpe:" \
          "2.3:" \
          "#{%w[a h o].sample}:" \
          "#{copyright.gsub(/\s+/, "-").underscore}:" \
          "#{name.underscore}:" \
          "#{version}:" \
          "*:" \
          "*:" \
          "*:" \
          "*:" \
          "*:" \
          "*:" \
          "*"
      end
      purl do
        # scheme:type/namespace/name@version?qualifiers#subpath
        "pkg:" \
          "#{%w[apk cargo gem github npm].sample}/" \
          "#{copyright.gsub(/\s+/, "-").underscore}/" \
          "#{name.underscore}@#{version}" \
          "?release=#{%w[alpha beta rc stable].sample}" \
          "#some/subpath/#{Faker::Lorem.word.downcase}"
      end
      omnibor_id do
        Array.new(rand(1..4)) do
          sha_type = %w[sha1 sha256].sample
          shasum = sha_type == "sha1" ? Faker::Crypto.sha1 : Faker::Crypto.sha256

          "gitoid:" \
            "#{%w[blob tree commit tag].sample}:" \
            "#{sha_type}:" \
            "#{shasum}"
        end
      end
      swhid do
        Array.new(rand(1..4)) do
          "swh:" \
            "1:" \
            "#{%w[cnt dir rel rev snp].sample}:" \
            "#{Faker::Crypto.sha1}"
        end
      end
      swid { association(:swid, :all_fields) }
      modified { Faker::Boolean.boolean }
      pedigree { association(:pedigree, :all_fields) }
      external_references { Array.new(rand(1..4)) { association(:external_reference, :all_fields) } }
      components { [] }
      evidence { association(:component_evidence, :all_fields) }
      release_notes { association(:release_notes, :all_fields) }
      model_card { association(:model_card, :all_fields) }
      data { Array.new(rand(1..4)) { association(:component_data, :all_fields) } }
      crypto_properties { association(:crypto_properties, :all_fields) }
      properties { Array.new(rand(1..4)) { association(:property, :all_fields) } }
      tags { Array.new(rand(1..4)) { Faker::Lorem.word } }
      signature { association(:signature, :all_fields) }
    end

    after(:build) do |component|
      if component.pedigree.present?
        component.pedigree.ancestors ||= []
        component.pedigree.ancestors << component
        component.pedigree.ancestors.uniq!
      end
    end
  end

  factory :pedigree, parent: :schema_object, class: "SBOM::CycloneDX::Component::Pedigree" do
    trait :all_fields do
      ancestors { [] }
      descendants { [] }
      variants { [] }
      commits { Array.new(rand(1..4)) { association(:commit, :all_fields) } }
      patches { Array.new(rand(1..4)) { association(:patch, :all_fields) } }
      notes { Faker::Lorem.sentence }
    end
  end
end
