# frozen_string_literal: true

require "spec_helper"

class ConcreteRecord < SBOM::CycloneDX::Record::Base
  class InnerRecord < SBOM::CycloneDX::Record::Base
    json_name "someInnerRecord"
    prop :integer_prop, :integer, json_name: "integer-prop"
  end

  prop :string_prop, :string
  prop :record_prop, InnerRecord
end

describe SBOM::CycloneDX::Record::Base do
  before(:each, :skip_body_check) do
    allow(described_class).to receive(:in_subclass_body?).and_return(true)
  end

  context "with singleton class" do
    describe "#fields" do
      it "returns a Hash of Fields" do
        fields = ConcreteRecord.fields

        expect(fields).to be_a(Hash)
        expect(fields.keys).to contain_exactly(:string_prop, :record_prop)
        expect(fields.values.all? { |f| f < SBOM::CycloneDX::Field::Base }).to be(true)
      end
    end

    describe "#json_create" do
      it "creates a new instance of the class from a symbol-keyed JSON representation" do
        json_hash = { string_prop: "value", record_prop: { "integer-prop": 1 } }
        result = ConcreteRecord.json_create(json_hash)
        expect(result).to be_a(ConcreteRecord)
        expect(result.string_prop).to eq("value")
        expect(result.record_prop).to be_a(ConcreteRecord::InnerRecord)
        expect(result.record_prop.integer_prop).to eq(1)
      end

      it "creates a new instance of the class from a string-keyed JSON representation" do
        json_hash = { "string_prop" => "value", "record_prop" => { "integer-prop" => 1 } }
        result = ConcreteRecord.json_create(json_hash)
        expect(result).to be_a(ConcreteRecord)
        expect(result.string_prop).to eq("value")
        expect(result.record_prop).to be_a(ConcreteRecord::InnerRecord)
        expect(result.record_prop.integer_prop).to eq(1)
      end
    end

    describe "#json_name" do
      context "when called with an argument" do
        it "sets the JSON name for the class if called within the class body" do
          expect(ConcreteRecord::InnerRecord.json_name).to eq("someInnerRecord")
        end

        it "raises an error if called outside the class body" do
          expect do
            ConcreteRecord.json_name("concrete-record")
          end.to raise_error("json_name can only be set within the class body")
        end
      end

      context "when called without an argument" do
        it "returns the JSON name for the class if one was set" do
          expect(ConcreteRecord::InnerRecord.json_name).to eq("someInnerRecord")
        end

        it "returns the bare class name if no JSON name was set" do
          expect(ConcreteRecord.json_name).to eq("ConcreteRecord")
        end

        it "returns 'Record' if no JSON name was set and the class name is nil" do
          expect(Class.new(described_class).json_name).to eq("Record")
        end
      end
    end

    describe "#prop" do
      subject(:prop_test) { Class.new(described_class) }

      it "raises an error if called outside the class body" do
        expect do
          prop_test.prop(:bad_prop, :string)
        end.to raise_error("properties must be defined in the class body of a subclass of Record")
      end

      it "raises an error if called on the abstract class" do
        expect do
          described_class.prop(:bad_prop, :string)
        end.to raise_error("properties cannot be defined for abstract Record")
      end

      it "raises an error if a property is defined more than once", :skip_body_check do
        expect do
          prop_test.prop(:a_prop, :integer)
          prop_test.prop(:a_prop, :string)
        end.to raise_error("property a_prop already defined")
      end

      it "creates a new field with the specified name and type", :skip_body_check do
        prop_test.prop(:string_prop, :string)
        expect(prop_test.fields[:string_prop].validator).to be_a(SBOM::CycloneDX::Validator::StringValidator)
      end

      it "accepts the :required flag", :skip_body_check do
        prop_test.prop(:string_prop, :string, required: true)
        expect(prop_test.fields[:string_prop].required?).to be(true)
      end

      it "accepts additional type-specific options", :skip_body_check do
        test_pattern = /test/
        prop_test.prop(:string_prop, :string, pattern: test_pattern)
        expect(prop_test.fields[:string_prop].validator.instance_variable_get(:@pattern)).to eq(test_pattern)
      end

      it "defines a getter method for the property", :skip_body_check do
        prop_test.prop(:string_prop, :string)
        expect(prop_test.new).to respond_to(:string_prop)
      end

      it "defines a setter method for non-const properties", :skip_body_check do
        prop_test.prop(:string_prop, :string)
        expect(prop_test.new).to respond_to(:string_prop=)
      end

      it "does not define a setter method for const properties", :skip_body_check do
        prop_test.prop(:string_prop, :string, const: "test")
        expect(prop_test.new).not_to respond_to(:string_prop=)
      end

      it "defines a predicate method for the property with a '?' suffix", :skip_body_check do
        prop_test.prop(:string_prop, :string)
        expect(prop_test.new).to respond_to(:string_prop?)
      end

      it "defines a _valid? method for the property", :skip_body_check do
        prop_test.prop(:string_prop, :string)
        expect(prop_test.new).to respond_to(:string_prop_valid?)
      end
    end

    describe "#const" do
      subject(:const_test) { Class.new(described_class) }

      it "is syntactic sugar for prop with :const value", :skip_body_check do
        # rubocop:disable RSpec/SubjectStub
        allow(const_test).to receive(:prop).and_call_original

        const_test.const(:const_prop, :string, "test")

        expect(const_test).to have_received(:prop)
          .with(:const_prop, :string, const: "test", json_name: nil, required: false)
        # rubocop:enable RSpec/SubjectStub
      end
    end

    describe "#validate" do
      subject(:validate_test) { Class.new(described_class) }

      it "raises an error if called outside the class body" do
        expect do
          validate_test.validate(:bad_prop, presence: :one)
        end.to raise_error("custom validators must be defined in the class body of a subclass of Record")
      end

      it "raises an error if called on the abstract class" do
        expect do
          described_class.validate(:bad_prop, presence: :one)
        end.to raise_error("custom validators cannot be defined for abstract Record")
      end

      it "raises an error if provided with both :presence option and a block", :skip_body_check do
        expect do
          validate_test.validate(:bad_prop, presence: :one) { |value| value == "test" }
        end.to raise_error("cannot provide both :presence and a block")
      end

      # TODO: Test that we correctly create the validators here
      it "accepts presence validtaion with :all, :any, or :one", :skip_body_check do
        expect do
          validate_test.validate(:prop1, :prop2, presence: :all)
          validate_test.validate(:prop1, :prop2, presence: :any)
          validate_test.validate(:prop1, :prop2, presence: :one)
        end.not_to raise_error
      end

      it "accepts a block for running custom validations", :skip_body_check do
        expect do
          validate_test.validate(:prop1, :prop2) { |value1, value2| value1 == value2 }
        end.not_to raise_error
      end
    end
  end

  describe "#initialize" do
    context "when called on the abstract class" do
      it "raises an error when instantiated" do
        expect { described_class.new }.to raise_error("Cannot instantiate abstract Record")
      end
    end

    context "when called on a subclass" do
      subject(:record_class) do
        allow(described_class).to receive(:in_subclass_body?).and_return(true)

        Class.new(described_class) do
          prop :string_prop, :string
          prop :integer_prop, :integer, default: 1
          prop :required_prop, :string, required: true
          const :const_prop, :string, "test"
        end
      end

      it "does not raise an error when instantiated" do
        expect { record_class.new(required_prop: "a") }.not_to raise_error
      end

      it "populates fields with provided values" do
        result = record_class.new(string_prop: "a string", required_prop: "a required string", integer_prop: 2)

        expect(result.string_prop).to eq("a string")
        expect(result.required_prop).to eq("a required string")
        expect(result.integer_prop).to eq(2)
      end

      it "populates defaults when values are not provided" do
        expect(record_class.new(required_prop: "a").integer_prop).to eq(1)
      end

      it "raises an error when a value is provided for a const field" do
        expect do
          record_class.new(const_prop: "new value")
        end.to raise_error("Can not reassign a const field")
      end

      it "raises an error when an unknown field is provided" do
        expect do
          record_class.new(required_prop: "a", unknown_field: "value")
        end.to raise_error("Unknown field(s): unknown_field")
      end

      it "checks validity of the record" do
        result = record_class.new(required_prop: "a")
        expect(result.errors).not_to be_empty
        expect(result.errors.values.all?(&:empty?)).to be(true)
      end
    end
  end

  describe "#<=>" do
    subject(:comparable_record) do
      allow(described_class).to receive(:in_subclass_body?).and_return(true)

      Class.new(described_class) do
        prop :string_prop, :string
        prop :integer_prop, :integer
        prop :boolean_prop, :boolean
        prop :property_prop, SBOM::CycloneDX::Record::Property
      end
    end

    it "returns nil if records are not of the same type", :skip_body_check do
      record = comparable_record.new(string_prop: "a", integer_prop: 1, boolean_prop: true)
      other_record = Class.new(described_class) do
        prop :string_prop, :string
        prop :integer_prop, :integer
        prop :boolean_prop, :boolean
      end.new(string_prop: "a", integer_prop: 1, boolean_prop: true)

      expect(record <=> other_record).to be_nil
    end

    it "returns 0 if all record fields match", :skip_body_check do
      record = comparable_record.new(string_prop: "a", integer_prop: 1, boolean_prop: true)
      other_record = comparable_record.new(string_prop: "a", integer_prop: 1, boolean_prop: true)

      expect(record <=> other_record).to eq(0)
    end

    it "returns non-zero if records differ", :skip_body_check do
      record = comparable_record.new(string_prop: "a", integer_prop: 1, boolean_prop: true)
      other_record = comparable_record.new(string_prop: "a", integer_prop: 1, boolean_prop: false)

      expect(record <=> other_record).not_to eq(0)
    end

    it "recursively compares nested records", :skip_body_check do
      record = comparable_record.new(property_prop: SBOM::CycloneDX::Record::Property.new(name: "a"))
      matching_record = comparable_record.new(property_prop: SBOM::CycloneDX::Record::Property.new(name: "a"))
      mismatching_record = comparable_record.new(property_prop: SBOM::CycloneDX::Record::Property.new(name: "b"))

      expect(record <=> matching_record).to eq(0)
      expect(record <=> mismatching_record).not_to eq(0)
    end
  end

  describe "#valid?" do
    subject(:record_class) do
      allow(described_class).to receive(:in_subclass_body?).and_return(true)

      Class.new(described_class) do
        prop :string_prop, :string
        prop :other_string_prop, :string
        prop :integer_prop, :integer, maximum: 10
        prop :other_integer_prop, :integer
        prop :float_prop, :float
        prop :boolean_prop, :boolean
        validate :string_prop, :other_string_prop, presence: :one
        validate :integer_prop, :other_integer_prop, presence: :any
        validate :float_prop, :boolean_prop, presence: :all
      end
    end

    it "returns true if all fields are valid" do
      record = record_class.new(string_prop: "a", integer_prop: 1, float_prop: 2.0, boolean_prop: false)
      expect(record).to be_valid
    end

    it "returns false if any field is invalid" do
      record = record_class.new(string_prop: "a", integer_prop: 11, float_prop: 2.0, boolean_prop: false)
      expect(record).not_to be_valid
    end

    it "runs presence validations" do
      expect(
        record_class
          .new(string_prop: "a", other_string_prop: "b", integer_prop: 1, float_prop: 2.0, boolean_prop: false)
      ).not_to be_valid

      expect(record_class.new(string_prop: "a", float_prop: 2.0, boolean_prop: false)).not_to be_valid
      expect(record_class.new(string_prop: "a", integer_prop: 1, float_prop: 2.0)).not_to be_valid
    end

    it "populates the errors hash" do
      record = record_class.new(string_prop: "a", integer_prop: 1, float_prop: 2.0, boolean_prop: false)
      expect(record).to be_valid
      expect(record.errors.values.all?(&:empty?)).to be(true)

      record.integer_prop = 11
      expect(record).not_to be_valid
      expect(record.errors[:integer_prop]).to eq(["Value is not within range"])
    end

    context "when custom validations are present" do
      it "runs the custom validations"
      it "does not add any errors when custom validations return \"\", true, or nil"
      it "adds an error when custom validations return a string"
      it "adds multiple errors when custom validations return an array of strings"
      it "adds a basic error when custom validations return false"
      it "adds the stringified return value when custom validations return an unexpected value"
    end
  end

  describe "#valid!" do
    it "raises an error if the record is invalid"
    it "does not raise an error if the record is valid"
  end

  describe "#formatted_errors" do
    it "returns a formatted string of errors"
  end
end
