# frozen_string_literal: true

require "sbom/cyclone_dx/enum"

FactoryBot.define do
  factory :component, parent: :record, class: "SBOM::CycloneDX::Record::Component" do
    type { SBOM::CycloneDX::Enum::COMPONENT_TYPE.sample }
    name { Faker::Lorem.word }

    trait :all_fields do
      mime_type { generate(:mime_type) }
      bom_ref { generate(:ref_link) }
      supplier factory: :organizational_entity
      manufacturer factory: :organizational_entity
      authors { association_list(:organizational_contact) }
      publisher { Faker::Lorem.word }
      group { Faker::Lorem.word }
      version { Faker::App.semantic_version }
      description { Faker::Lorem.sentence }
      scope { SBOM::CycloneDX::Enum::SCOPE.sample }
      hashes { association_list(:hash_data) }
      licenses { license_choice_list(rand(1..3)) }
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
      swid
      modified { Faker::Boolean.boolean }
      pedigree
      external_references { association_list(:external_reference) }
      components { [] }
      evidence factory: :component_evidence
      release_notes
      model_card
      data { association_list(:component_data) }
      crypto_properties
      properties { association_list(:property) }
      tags { Array.new(rand(1..4)) { Faker::Lorem.word } }
      signature { generate_signature }
    end

    after(:build) do |component|
      if component.pedigree.present?
        component.pedigree.ancestors ||= []
        component.pedigree.ancestors << component
        component.pedigree.ancestors.uniq!
      end
    end
  end

  factory :pedigree, parent: :record, class: "SBOM::CycloneDX::Record::Component::Pedigree" do
    trait :all_fields do
      ancestors { [] }
      descendants { [] }
      variants { [] }
      commits { association_list(:commit) }
      patches { association_list(:patch) }
      notes { Faker::Lorem.sentence }
    end
  end
end
