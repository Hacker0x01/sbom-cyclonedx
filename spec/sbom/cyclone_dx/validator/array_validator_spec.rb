# frozen_string_literal: true

require "spec_helper"

describe SBOM::CycloneDX::Validator::ArrayValidator do
  describe "#initialize" do
    it "requires :items" do
      expect { described_class.new(items: :string) }.not_to raise_error
      # This may raise RBS::Test::Tester::TypeError or ArgumentError, depending on test context
      expect { described_class.new }.to raise_error(Exception)
    end
  end

  it "supports uniqueness checking" do
    expect(described_class.new(items: :integer, unique: true).validate([1, 2, 3])).to be_empty
    expect(described_class.new(items: :integer, unique: true).validate([1, 2, 2])).not_to be_empty
  end

  context "when :items is a symbol" do
    let(:items) { :string }
    let(:value) { %w[a bb ccc] }

    describe "#initialize" do
      it "accepts all symbols representing simple types" do
        SBOM::CycloneDX::Validator::SIMPLE_TYPES.each do |simple_type|
          expect { described_class.new(items: simple_type) }.not_to raise_error
        end
      end

      it "rejects symbols that are not simple types" do
        %i[array union record invalid].each do |invalid_type|
          # This may raise RBS::Test::Tester::TypeError or ArgumentError, depending on test context
          expect { described_class.new(items: invalid_type) }.to raise_error(Exception)
        end
      end
    end

    describe "#validate" do
      subject(:instance) { described_class.new(items: items) }

      it "does not permit nil elements" do
        expect(instance.validate(value.push(nil).shuffle)).not_to be_empty
      end

      it "returns an empty array when all elements are of the specified type" do
        expect(instance.validate(value)).to be_empty
      end

      it "returns an array of error messages when any element is not of the specified type" do
        expect(instance.validate(value.push(1).shuffle)).not_to be_empty
      end
    end
  end

  context "when :items is a Class" do
    let(:items) { SBOM::CycloneDX::Record::Property }
    let(:value) { Array.new(rand(1..5)) { items.new(name: Faker::Lorem.word, value: Faker::Lorem.sentence) } }

    describe "#initialize" do
      it "accepts classes for Record types" do
        expect { described_class.new(items: items) }.not_to raise_error
      end

      it "rejects classes that are not Record types" do
        # This may raise RBS::Test::Tester::TypeError or ArgumentError, depending on test context
        expect { described_class.new(items: String) }.to raise_error(Exception)
      end
    end

    describe "#validate" do
      subject(:instance) { described_class.new(items: items) }

      it "does not permit nil elements" do
        expect(instance.validate(value.push(nil).shuffle)).not_to be_empty
      end

      it "returns an empty array when all elements are of the specified type and valid" do
        expect(instance.validate(value)).to be_empty
      end

      it "returns an array of error messages when any element is invalid" do
        bad_items = [
          SBOM::CycloneDX::Record::Declarations::Attestation::Map::Confidence.new(score: 0.1),
          SBOM::CycloneDX::Record::Declarations::Attestation::Map::Confidence.new(score: 2.5),
          SBOM::CycloneDX::Record::Declarations::Attestation::Map::Confidence.new(score: 0.9)
        ]
        confidence_instance =
          described_class.new(items: SBOM::CycloneDX::Record::Declarations::Attestation::Map::Confidence)
        expect(confidence_instance.validate(bad_items)).not_to be_empty
      end

      it "returns an array of error messages when any element is not of the specified type" do
        value.push(SBOM::CycloneDX::Record::Copyright.new(text: Faker::Lorem.sentence))
        expect(instance.validate(value)).not_to be_empty
      end
    end
  end

  context "when :items is an Array" do
    let(:items) { [:string, min_length: 1, max_length: 2] }
    let(:value) { %w[a bb cc] }

    describe "#initialize" do
      it "accepts an array representing validator creation arguments" do
        expect { described_class.new(items: items) }.not_to raise_error
      end

      it "rejects an array that does not represent validator creation arguments" do
        # This may raise RBS::Test::Tester::TypeError or ArgumentError, depending on test context
        expect { described_class.new(items: %i[string integer]) }.to raise_error(Exception)
      end
    end

    describe "#validate" do
      subject(:instance) { described_class.new(items: items) }

      it "does not permit nil elements by default" do
        expect(instance.validate(value.push(nil).shuffle)).not_to be_empty
      end

      it "allows permitting nil elements" do
        items.last[:required] = false
        nilable_instance = described_class.new(items: items)
        expect(nilable_instance.validate(value.push(nil).shuffle)).to be_empty
      end

      it "returns an empty array when all elements are valid" do
        expect(instance.validate(value)).to be_empty
      end

      it "returns an array of error messages when any element is invalid" do
        expect(instance.validate(value.push("dddd").shuffle)).not_to be_empty
      end
    end
  end

  context "when :items is a Proc" do
    let(:items) { ->(item) { item.even? && item < 10 } }
    let(:value) { [2, 4, 6] }

    describe "#initialize" do
      it "accepts a Proc" do
        expect { described_class.new(items: items) }.not_to raise_error
      end
    end

    describe "#validate" do
      subject(:instance) { described_class.new(items: items) }

      it "returns proc return value when proc returns an array" do
        expected_return = value.map { Faker::Lorem.word }
        message_stack = expected_return.reverse
        array_proc_instance = described_class.new(items: ->(_item) { message_stack.pop })
        expect(array_proc_instance.validate(value)).to match_array(expected_return)
      end

      it "wraps proc value in array when proc returns a string" do
        static_message = "some error message"
        expected_return = value.map { static_message }
        string_proc_instance = described_class.new(items: ->(_item) { static_message })
        expect(string_proc_instance.validate(value)).to match_array(expected_return)
      end

      it "returns a basic error message when proc returns false" do
        false_proc_instance = described_class.new(items: lambda(&:even?))
        expect(false_proc_instance.validate([5])).to contain_exactly("5 is invalid")
      end

      it "returns an empty array when proc returns true" do
        true_proc_instance = described_class.new(items: lambda(&:even?))
        expect(true_proc_instance.validate([4])).to be_empty
      end

      it "returns an empty array when all elements are valid" do
        expect(instance.validate(value)).to be_empty
      end

      it "returns an array of error messages when any element is invalid" do
        expect(instance.validate(value.push(11).shuffle)).not_to be_empty
      end
    end
  end
end
