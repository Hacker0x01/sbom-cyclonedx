# frozen_string_literal: true

require "spec_helper"

describe SBOM::CycloneDX::Validator::UnionValidator do
  describe "#initialize" do
    it "requires :of" do
      expect { described_class.new(of: %i[integer string]) }.not_to raise_error
      # This may raise RBS::Test::Tester::TypeError or ArgumentError, depending on test context
      expect { described_class.new }.to raise_error(Exception)
    end
  end

  context "when :of contains symbols" do
    let(:of) { %i[integer string] }
    let(:value) { [Faker::Number.number, Faker::Lorem.word].sample }

    describe "#initialize" do
      it "accepts symbols representing simple types" do
        expect { described_class.new(of: of) }.not_to raise_error
      end
    end

    describe "#validate" do
      subject(:instance) { described_class.new(of: of) }

      it "returns an empty array when value is one of the specified types" do
        expect(instance.validate(value)).to be_empty
      end

      it "returns an array of error messages when value is not one of the specified types" do
        expect(instance.validate(true)).not_to be_empty
      end
    end
  end

  context "when :of contains arrays" do
    let(:of) { [[:integer, minimum: 0, maximum: 10], [:string, min_length: 1, max_length: 2]] }
    let(:value) { [Faker::Number.within(range: 0..10), Faker::Lorem.characters(number: 1..2)].sample }

    describe "#initialize" do
      it "accepts an array representing validator creation arguments" do
        expect { described_class.new(of: of) }.not_to raise_error
      end

      it "rejects an array that does not represent validator creation arguments" do
        # This may raise RBS::Test::Tester::TypeError or ArgumentError, depending on test context
        expect { described_class.new(of: [:boolean, %i[string integer]]) }.to raise_error(Exception)
      end
    end

    describe "#validate" do
      subject(:instance) { described_class.new(of: of) }

      it "returns an empty array when all elements are valid" do
        expect(instance.validate(value)).to be_empty
      end

      it "returns an array of error messages when any element is invalid" do
        expect(instance.validate("dddd")).not_to be_empty
        expect(instance.validate(11)).not_to be_empty
      end
    end
  end
end
