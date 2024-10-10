# frozen_string_literal: true

require "spec_helper"
require "schema_object"

RSpec.describe SBOM::CycloneDX::SchemaObject do
  let(:klass_name) { "LibraryBook" }
  let(:klass_json_alias) { "libraryBook" }

  it "creates a class with the correct name" do
    klass = described_class.build(klass_name) {}
    expect(klass.name).to eq(klass_name)
  end

  it "creates a class with the correct JSON name" do
    klass = described_class.build(klass_name) {}
    expect(klass::JSON_NAME).to eq(klass_json_alias)
  end

  it "creates a class with the correct JSON name when specified" do
    klass = described_class.build(klass_name, json_alias: "library-book") {}
    expect(klass::JSON_NAME).to eq("library-book")
  end

  describe "const" do
    let(:const_values) do
      {
        const_integer: 1,
        const_float: 2.5,
        const_string: "constant_value",
        const_boolean: true,
        const_datetime: DateTime.new(2024, 10, 3, 17, 40, 32),
        const_uri: URI("https://example.com/path#fragment"),
        const_email_address: EmailAddress.new("test@example.com"),
        const_array: [1, "2", 1, :a, true],
        const_set: Set[2, "3", :a, true]
        # const_schema_object: other_schema_object # Not yet supported
      }
    end

    let(:klass) do
      described_class.build(klass_name) do
        const :const_integer, const_values[:const_integer]
        const :const_float, const_values[:const_float]
        const :const_string, const_values[:const_string]
        const :const_boolean, const_values[:const_boolean]
        const :const_datetime, const_values[:const_datetime]
        const :const_uri, const_values[:const_uri]
        const :const_email_address, const_values[:const_email_address]
        const :const_array, const_values[:const_array]
        const :const_set, const_values[:const_set]
        # const :const_schema_object, const_values[:const_schema_object] # Not yet supported
      end
    end

    it "creates a class with the correct constant properties" do
      instance = klass.new
      const_values.each do |name, value|
        expect(instance.send(name)).to eq(value)
        expect(instance[name]).to eq(value)
      end
    end

    it "raises an error when trying to initialize a constant property" do
      expect { klass.new(const_integer: 2) }.to raise_error(ArgumentError)
    end

    it "raises an error when trying to set a constant property" do
      instance = klass.new
      expect { instance.const_integer = 2 }.to raise_error(NoMethodError)
      expect { instance[:const_float] = 3.5 }.to raise_error(NameError)
    end
  end

  describe "prop" do
    it "generates a property with the correct name"
    it "generates a property with the correct type"
    it "generates a property with the correct JSON name"
    it "allows overriding the default JSON name"

    context "when casting values"
    context "when specifying a required property"
    context "when specifying a property with a default value"

    context "when specifying validators" do
      it "validates properties during initialization"
      it "validates properties when setting values"

      context "when specifying a custom validator"
      context "when validating numeric properties"
      context "when validating string properties"
    end

    context "when specifying a constant value" do
      it "raises an error if no default is provided" do
        expect do
          described_class.build(klass_name) do
            prop :const_integer, Integer
          end
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe "to_json"
end
