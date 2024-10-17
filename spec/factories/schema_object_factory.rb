# frozen_string_literal: true

require "faker"
require "i18n"
require "sbom/cyclone_dx"
require "sbom/cyclone_dx/schema_object"

module SBOM
  module CycloneDX
    module MockSchemaObject
      class Basic < Struct.new("Basic", :string_value, keyword_init: true)
        include SBOM::CycloneDX::SchemaObject

        def valid?
          Validator.valid?(String, string_value)
        end
      end

      class AllTypes < Struct.new(
        "AllTypes",
        :string_value,
        :integer_value,
        :float_value,
        :boolean_value,
        :basic_schema_object_value,
        :array_value,
        :datetime_value,
        :uri_value,
        :union_value,
        :email_address_value,
        keyword_init: true
      )
        include SBOM::CycloneDX::SchemaObject

        def valid? # rubocop:disable Metrics/PerceivedComplexity
          Validator.valid?(String, string_value) &&
            Validator.valid?(Integer, integer_value) &&
            Validator.valid?(Float, float_value) &&
            Validator.valid?(SBOM::CycloneDX::Type::Boolean, boolean_value) &&
            Validator.valid?(Basic, basic_schema_object_value) &&
            Validator.valid?(Array, array_value, items: String) &&
            Validator.valid?(DateTime, datetime_value) &&
            Validator.valid?(URI, uri_value) &&
            Validator.valid?(SBOM::CycloneDX::Type::Union, union_value, klasses: [String, Integer]) &&
            Validator.valid?(SBOM::CycloneDX::EmailAddress, email_address_value)
        end
      end

      class RequiredMembers < Struct.new(
        "RequiredMembers",
        :always_required,
        :required_when_other_nil_a,
        :required_when_other_nil_b,
        :required_when_other_present,
        :optional,
        keyword_init: true
      )
        include SBOM::CycloneDX::SchemaObject

        # Some of these conditions don't exist in the gem yet, but they are here to show how we could handle more-
        # complex validation logic.
        def initialize( # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength
          always_required:,
          or_required_a: nil,
          or_required_b: nil,
          xor_required_a: nil,
          xor_required_b: nil,
          impl_required_a: nil,
          impl_required_b: nil,
          at_least_one_a: nil,
          optional: nil
        )
          # This pattern is gross, but good enough until Validator provides errors
          raise "always_required is required" if always_required.nil?
          raise "either or_required_a or or_required_b must be present" if or_required_a.nil? || or_required_b.nil?
          if xor_required_a.nil? ^ xor_required_b.nil?
            raise "xor_required_a or xor_required_b must be present, but not both"
          end
          if impl_required_a.present? && impl_required_b.nil?
            raise "impl_required_b must be present if impl_required_a is present"
          end
          if [or_required_a, xor_required_a, impl_required_a, at_least_one_a].none?
            raise "at least one of or_required_a, xor_required_a, impl_required_a, or at_least_one_a must be present"
          end

          super
        end

        def valid?
          Validator.valid?(String, always_required, required: true) &&
            or_required_valid? &&
            xor_required_valid? &&
            at_least_one_valid? &&
            Validator.valid?(String, impl_required_a) &&
            Validator.valid?(String, optional)
        end

        private

        def or_required_valid?
          Validator.valid?(String, or_required_a, required: or_required_b.nil?) &&
            Validator.valid?(String, or_required_b, required: or_required_a.nil?)
        end

        def xor_required_valid?
          (xor_required_a.nil? ^ xor_required_b.nil?) &&
            Validator.valid?(String, xor_required_a, required: xor_required_b.nil?) &&
            Validator.valid?(String, xor_required_b, required: xor_required_a.nil?)
        end

        def impl_required_valid?
          Validator.valid?(String, impl_required_b, required: impl_required_a.present?)
        end

        def at_least_one_valid?
          Validator.valid?(
            String,
            at_least_one_a,
            required: [or_required_a, xor_required_a, impl_required_a].none?
          )
        end
      end
    end
  end
end

FactoryBot.define do
  FactoryHelper.create_generators_on(self)

  factory :schema_object, class: "SBOM::CycloneDX::SchemaObject" do
    initialize_with { new(**attributes) }

    factory :mock_schema_object, class: "SBOM::CycloneDX::SchemaObject" do
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

      trait :basic_schema_object_value do
        basic_schema_object_value { basic_schema_object }
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
          [SBOM::CycloneDX::EmailAddress.new(Faker::Internet.email), Faker::Internet.email].sample
        end
      end

      factory :basic_schema_object, class: "SBOM::CycloneDX::MockSchemaObject::Basic", traits: [:string_value]

      factory :all_types_schema_object, class: "SBOM::CycloneDX::MockSchemaObject::AllTypes", traits: %i[
        string_value
        integer_value
        float_value
        boolean_value
        basic_schema_object_value
        array_value
        datetime_value
        uri_value
        union_value
        email_address_value
      ]

      factory :required_members_schema_object, class: "SBOM::CycloneDX::MockSchemaObject::RequiredMembers" do
        trait :valid do
          always_required { Faker::Lorem.word }
          or_required_b { Faker::Lorem.word }
          xor_required_b { Faker::Lorem.word }
          at_least_one_a { Faker::Lorem.word }
        end

        trait :missing_always_required do
          or_required_b { Faker::Lorem.word }
          xor_required_b { Faker::Lorem.word }
          at_least_one_a { Faker::Lorem.word }
        end

        trait :missing_or_required do
          always_required { Faker::Lorem.word }
          xor_required_b { Faker::Lorem.word }
          at_least_one_a { Faker::Lorem.word }
        end

        trait :missing_xor_required do
          always_required { Faker::Lorem.word }
          or_required_b { Faker::Lorem.word }
          at_least_one_a { Faker::Lorem.word }
        end

        trait :both_xor_required do
          always_required { Faker::Lorem.word }
          or_required_b { Faker::Lorem.word }
          xor_required_a { Faker::Lorem.word }
          xor_required_b { Faker::Lorem.word }
          at_least_one_a { Faker::Lorem.word }
        end

        trait :missing_impl_required do
          always_required { Faker::Lorem.word }
          or_required_b { Faker::Lorem.word }
          xor_required_b { Faker::Lorem.word }
          impl_required_a { Faker::Lorem.word }
          at_least_one_a { Faker::Lorem.word }
        end

        trait :missing_at_least_one do
          always_required { Faker::Lorem.word }
          or_required_b { Faker::Lorem.word }
          xor_required_b { Faker::Lorem.word }
        end
      end

      # The following logic can be used if we'd like to be more dynamic about generating these factories. However, it is
      # unnecessarily complex for the current needs of this gem.
      ####################################################################################################################

      # validators { members.transform_values { |data| data[:validator] } }
      # initializer do
      #   required_members = members.select { |_, data| data.dig(:required, false) }.keys
      #   next if required_members.empty?

      #   optional_members = members.except(*required_members).transform_values { |data| data[:default] }

      #   required_member_args = required_members.map { |m| "#{m}:" }.join(", ").presence
      #   optional_member_args = optional_members.map { |m, v| "#{m}: #{v.inspect}" }.join(", ").presence
      #   all_args = [required_member_args, optional_member_args].compact.join(", ")
      #   super_args = members.keys.map { |m| "#{m}: #{m}" }.join(", ")

      #   <<~RUBY
      #     def initialize(#{all_args})
      #       super(#{super_args})
      #     end
      #   RUBY
      # end

      # initialize_with do
      #   klass = Class.new(Struct.new(name, *members.keys, keyword_init: true)) do
      #     include SBOM::CycloneDX::SchemaObject
      #   end

      #   # This only happens in factories, where we need to generate validators
      #   klass.const_set(:VALIDATORS, validators.freeze)
      #   klass.instance_eval(initializer) if initializer.present?

      #   klass.define_method(:valid?) do
      #     VALIDATORS.all? do |member, args|
      #       Validator.valid?(args.shift, send(member), **args.first)
      #     end
      #   end

      #   klass.new(name: name, **members.transform_values { |data| data[:generator].call })
      # end
    end
  end
end
