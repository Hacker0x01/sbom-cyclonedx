# frozen_string_literal: true

require "spec_helper"
require "active_support/all"
require "sbom/cyclone_dx"
require "sbom/cyclone_dx/record"
require "sbom/cyclone_dx/validator"

describe SBOM::CycloneDX::Validator do
  let(:sample_data) do
    {
      String => Faker::Lorem.words(number: 4),
      Integer => Array.new(4) { rand(-100..100) },
      Float => Array.new(4) { rand(-100..100) + rand(0.01..0.99) },
      :boolean => [true, false],
      SBOM::CycloneDX::Record => [build(:basic_record), build(:basic_record)],
      Array => [[1, 2, 3], [4, 5, 6]],
      # DateTime supports Time and DateTime objects, but not Date objects (per JSON schema)
      DateTime => [1.day.ago, DateTime.now, Time.current.iso8601],
      URI => [URI.parse(Faker::Internet.url), Faker::Internet.url],
      :union => Faker::Lorem.words(number: 4) + Array.new(4) { rand(1..100) },
      SBOM::CycloneDX::EmailAddress => [
        SBOM::CycloneDX::EmailAddress.new(Faker::Internet.email),
        Faker::Internet.email
      ],
      Exception => [
        TypeError.new("we will never support this type as a field value"),
        ArgumentError.new("we will also never support this type as a field value")
      ]
    }
  end

  describe "#valid?" do
    shared_examples "typed" do |klass|
      let(:extra_args) do
        next { klasses: sample_data[:union].map(&:class).uniq } if klass == :union
        next { items: sample_data.dig(Array, 0, 0).class } if klass == Array

        {}
      end

      it "returns true when object is of the correct type" do
        expect(described_class).to be_valid(klass, sample_data[klass].sample, **extra_args)
      end

      it "returns false when object is not of the correct type" do
        other_klasses = [
          Integer,
          Float,
          :boolean,
          Array
        ] - extra_args.fetch(:klasses, [klass])
        other_klass_value = sample_data[other_klasses.sample].sample

        expect(described_class).not_to be_valid(klass, other_klass_value, **extra_args)
      end
    end

    shared_examples "required" do |klass|
      let(:extra_args) do
        next { klasses: sample_data[:union].map(&:class).uniq } if klass == :union
        next { items: sample_data.dig(Array, 0, 0).class } if klass == Array

        {}
      end

      context "when object is required" do
        it "returns true when object is valid and not nil" do
          expect(described_class).to be_valid(klass, sample_data[klass].sample, required: true, **extra_args)
        end

        it "returns false when object is nil" do
          expect(described_class).not_to be_valid(klass, nil, required: true, **extra_args)
        end
      end

      context "when object is not required" do
        it "returns true when object is valid and not nil" do
          expect(described_class).to be_valid(klass, sample_data[klass].sample, **extra_args)
        end

        it "returns true when object is nil" do
          expect(described_class).to be_valid(klass, nil, **extra_args)
        end
      end
    end

    shared_examples "const" do |klass|
      context "when object is a constant value" do
        let(:const_value) { sample_data[klass].sample }
        let(:other_value) { (sample_data[klass] - [const_value]).sample }

        let(:extra_args) do
          next { klasses: sample_data[:union].map(&:class).uniq } if klass == :union
          next { items: sample_data.dig(Array, 0, 0).class } if klass == Array

          {}
        end
        let(:other_klass_value) { sample_data[other_klass].sample }

        it "returns true when object is a #{klass} with the correct value" do
          expect(described_class).to be_valid(klass, const_value, const: const_value, **extra_args)
        end

        it "returns false when object is a #{klass} with a different value" do
          expect(described_class).not_to be_valid(klass, other_value, const: const_value, **extra_args)
        end

        it "raises an exception when given const value is not a #{klass}" do
          other_klasses = [
            Integer,
            Float,
            :boolean,
            Array
          ] - extra_args.fetch(:klasses, [klass])
          other_klass_value = sample_data[other_klasses.sample].sample
          expect do
            described_class.valid?(klass, other_klass_value, const: other_klass_value, **extra_args)
          end.to raise_error(ArgumentError, "const value has wrong type: #{other_klass_value.class}")
        end
      end
    end

    shared_examples "numeric" do |klass|
      let(:value) { sample_data[klass].sample }

      it "returns a boolean describing whether or not the number is greater than or equal to a specified maximum" do
        expect(described_class).to be_valid(klass, value, maximum: value + 1)
        expect(described_class).to be_valid(klass, value, maximum: value)
        expect(described_class).not_to be_valid(klass, value, maximum: value - 1)
      end

      it "returns a boolean describing whether or not the number is less than or equal to a specified minimum" do
        expect(described_class).to be_valid(klass, value, minimum: value - 1)
        expect(described_class).to be_valid(klass, value, minimum: value)
        expect(described_class).not_to be_valid(klass, value, minimum: value + 1)
      end
    end

    context "when klass is String" do
      include_examples "typed", String
      include_examples "required", String
      include_examples "const", String

      it "returns a boolean describing whether or not the string is in a specified enum" do
        enum = sample_data[String]
        expect(described_class).to be_valid(String, enum.sample, enum: enum)
        expect(described_class).not_to be_valid(String, "invalid: #{enum.join}", enum: enum)
      end

      it "returns a boolean describing whether or not the string is at most a specified max_length" do
        value = sample_data[String].sample
        max_length = value.length
        expect(described_class).to be_valid(String, value, max_length: max_length + 1)
        expect(described_class).to be_valid(String, value, max_length: max_length)
        expect(described_class).not_to be_valid(String, value, max_length: max_length - 1)
      end

      it "returns a boolean describing whether or not the string is at least a specified min_length" do
        value = sample_data[String].sample
        min_length = value.length
        expect(described_class).to be_valid(String, value, min_length: min_length - 1)
        expect(described_class).to be_valid(String, value, min_length: min_length)
        expect(described_class).not_to be_valid(String, value, min_length: min_length + 1)
      end

      it "returns a boolean describing whether or not the string matches a specified pattern" do
        value = sample_data[String].sample
        pattern = /\A#{value}\z/
        expect(described_class).to be_valid(String, value, pattern: pattern)
        expect(described_class).not_to be_valid(String, "invalid: #{value}", pattern: pattern)
      end
    end

    context "when klass is Integer" do
      include_examples "typed", Integer
      include_examples "required", Integer
      include_examples "const", Integer
      include_examples "numeric", Integer
    end

    context "when klass is Float" do
      include_examples "typed", Float
      include_examples "required", Float
      include_examples "const", Float
      include_examples "numeric", Float
    end

    context "when klass is Boolean" do
      include_examples "typed", :boolean
      include_examples "required", :boolean
      include_examples "const", :boolean
    end

    context "when klass is a subclass of Record" do
      let(:inner_value) { Faker::Lorem.sentence }
      let(:record) { build(:basic_record, string_value: inner_value) }
      let(:klass) { record.class }

      it "returns true when object is of the correct type" do
        expect(described_class).to be_valid(record.class, record)
      end

      it "returns false when object is not of the correct type" do
        expect(described_class).not_to be_valid(klass, "Not a record!")
      end

      context "when object is required" do # rubocop:disable RSpec/NestedGroups
        it "returns true when object is valid and not nil" do
          expect(described_class).to be_valid(klass, record, required: true)
        end

        it "returns false when object is nil" do
          expect(described_class).not_to be_valid(klass, nil, required: true)
        end
      end

      context "when object is not required" do # rubocop:disable RSpec/NestedGroups
        it "returns true when object is valid and not nil" do
          expect(described_class).to be_valid(klass, record)
        end

        it "returns true when object is nil" do
          expect(described_class).to be_valid(klass, nil)
        end
      end

      it "returns true when object is a Record with the correct value" do
        const_record = build(:basic_record, string_value: inner_value)
        expect(described_class).to be_valid(klass, record, const: const_record)
      end

      it "returns false when object is a Record with a different value" do
        const_record = build(:basic_record, string_value: "not #{inner_value}")
        expect(described_class).not_to be_valid(klass, record, const: const_record)
      end

      it "raises an exception when given const value is not a Record" do
        expect do
          described_class.valid?(klass, "not a record!", const: "not a record!")
        end.to raise_error(ArgumentError, "const value has wrong type: String")
      end
    end

    context "when klass is Array" do
      include_examples "typed", Array
      include_examples "required", Array
      include_examples "const", Array

      it "raises an error if :items is not provided" do
        expect do
          described_class.valid?(Array, [1, 2, 3])
        end.to raise_error(ArgumentError, ":items must be provided for array validation")
      end

      it "supports :items being a proc that returns a boolean" do
        items = ->(item) { item.even? && item < 10 }
        expect(described_class).to be_valid(Array, [2, 4, 6], items: items)
        expect(described_class).not_to be_valid(Array, [2, 4, 7], items: items)
      end

      it "supports :items being a class that all values must be instances of" do
        expect(described_class).to be_valid(Array, [1, 2, 3], items: Integer)
        expect(described_class).not_to be_valid(Array, [1, 2, "3"], items: Integer)
      end

      it "supports :items being a tuple describing all values in the array" do
        items = [String, min_length: 1, max_length: 2]
        expect(described_class).to be_valid(Array, %w[a bb cc], items: items)
        expect(described_class).not_to be_valid(Array, %w[a bb ccc], items: items)
      end

      it "supports uniqueness checking" do
        expect(described_class).to be_valid(Array, [1, 2, 3], items: Integer, unique: true)
        expect(described_class).not_to be_valid(Array, [1, 2, 2], items: Integer, unique: true)
      end
    end

    context "when klass is DateTime" do
      include_examples "typed", DateTime
      include_examples "required", DateTime
      include_examples "const", DateTime

      # The json spec requires iso8601 formatted strings *with* time + zone
      it "does not support Date objects" do
        expect(described_class).not_to be_valid(DateTime, Date.today)
      end
    end

    context "when klass is URI" do
      include_examples "typed", URI
      include_examples "required", URI
      include_examples "const", URI
    end

    context "when klass is Union" do
      include_examples "typed", :union
      include_examples "required", :union
      include_examples "const", :union

      it "raises an error if :klasses is not provided" do
        expect do
          described_class.valid?(:union, sample_data[:union].sample)
        end.to raise_error(ArgumentError, ":klasses must be provided for union validation")
      end
    end

    context "when klass is EmailAddress" do
      include_examples "typed", SBOM::CycloneDX::EmailAddress
      include_examples "required", SBOM::CycloneDX::EmailAddress
      include_examples "const", SBOM::CycloneDX::EmailAddress
    end

    context "when klass is unsupported" do
      it "raises an exception" do
        expect do
          described_class.valid?(Exception, sample_data[Exception].sample)
        end.to raise_error(ArgumentError, "Unsupported type: Exception")
      end
    end
  end
end
