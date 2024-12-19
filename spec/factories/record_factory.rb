# frozen_string_literal: true

require "faker"
require "i18n"
require "sbom/cyclone_dx"
require "sbom/cyclone_dx/record"

module SBOM
  module CycloneDX
    module Record
      module MockRecord
        # Schema name: Basic
        class Basic < Base
          prop :string_value, :string
        end

        # Schema name: AllTypes
        class AllTypes < Base
          prop :string_value, :string
          prop :integer_value, :integer
          prop :float_value, :float
          prop :boolean_value, :boolean
          prop :basic_record_value, Basic
          prop :array_value, :array, items: :string
          prop :datetime_value, :date_time
          prop :uri_value, :uri
          prop :union_value, :union, of: %i[string integer]
          prop :email_address_value, :email_address
        end

        # Schema name: RequiredMembers
        class RequiredMembers < Base
          prop :always_required, :string, required: true
          prop :any_required_a, :string
          prop :any_required_b, :string
          prop :one_required_a, :string
          prop :one_required_b, :string
          prop :impl_required_a, :string
          prop :impl_required_b, :string
          prop :optional, :string

          validate :any_required_a, :any_required_b, presence: :any
          validate :one_required_a, :one_required_b, presence: :one
          validate(:impl_required_a, :impl_required_b) { |a, b| a.nil? || b.present? }
        end
      end
    end
  end
end

FactoryBot.define do
  factory :record, class: "SBOM::CycloneDX::Record" do
    initialize_with { new(**attributes) }

    factory :mock_record, class: "SBOM::CycloneDX::Record" do
      trait :string_value do
        string_value { Faker::Lorem.sentence }
      end

      trait :integer_value do
        integer_value { rand(1..100) }
      end

      trait :float_value do
        float_value { rand(1..100) + rand(0.01..0.99) }
      end

      trait :boolean_value do
        boolean_value { [true, false].sample }
      end

      trait :basic_record_value do
        basic_record_value { basic_record }
      end

      trait :array_value do
        array_value { Faker::Lorem.words(number: 4) }
      end

      trait :datetime_value do
        datetime_value { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
      end

      trait :uri_value do
        uri_value { [URI.parse(Faker::Internet.url), Faker::Internet.url].sample }
      end

      trait :union_value do
        union_value { [Faker::Marketing.buzzwords, rand(1..100)].sample }
      end

      trait :email_address_value do
        email_address_value do
          [EmailAddress::Address.new(Faker::Internet.email), Faker::Internet.email].sample
        end
      end

      factory :basic_record, class: "SBOM::CycloneDX::Record::MockRecord::Basic", traits: [:string_value]

      factory :all_types_record, class: "SBOM::CycloneDX::Record::MockRecord::AllTypes", traits: %i[
        string_value
        integer_value
        float_value
        boolean_value
        basic_record_value
        array_value
        datetime_value
        uri_value
        union_value
        email_address_value
      ]

      factory :required_members_record, class: "SBOM::CycloneDX::Record::MockRecord::RequiredMembers" do
        trait :valid do
          always_required { Faker::Lorem.word }
          any_required_b { Faker::Lorem.word }
          one_required_b { Faker::Lorem.word }
        end

        trait :missing_always_required do
          any_required_b { Faker::Lorem.word }
          one_required_b { Faker::Lorem.word }
        end

        trait :missing_any_required do
          always_required { Faker::Lorem.word }
          one_required_b { Faker::Lorem.word }
        end

        trait :missing_one_required do
          always_required { Faker::Lorem.word }
          any_required_b { Faker::Lorem.word }
        end

        trait :both_one_required do
          always_required { Faker::Lorem.word }
          any_required_b { Faker::Lorem.word }
          one_required_a { Faker::Lorem.word }
          one_required_b { Faker::Lorem.word }
        end

        trait :having_impl_required do
          always_required { Faker::Lorem.word }
          any_required_b { Faker::Lorem.word }
          one_required_b { Faker::Lorem.word }
          impl_required_a { Faker::Lorem.word }
          impl_required_b { Faker::Lorem.word }
        end

        trait :having_impl_required_missing do
          always_required { Faker::Lorem.word }
          any_required_b { Faker::Lorem.word }
          one_required_b { Faker::Lorem.word }
          impl_required_a { Faker::Lorem.word }
        end
      end
    end
  end
end
