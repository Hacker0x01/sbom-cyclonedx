# frozen_string_literal: true

require "spec_helper"
require "sbom/cyclone_dx/schema_object"
require "sbom/cyclone_dx/validator"
require "uri"
require "time"

describe SBOM::CycloneDX::SchemaObject do
  let(:field_values) do
    {
      string_field: "string",
      integer_field: 1,
      float_field: 2.5,
      boolean_field: true,
      datetime_field: DateTime.new(2024, 10, 14, 17, 24, 33),
      uri_field: URI("https://example.com"),
      email_address_field: SBOM::CycloneDX::EmailAddress.new("test@example.com"),
      array_field: ["value1", 2, true],
      special_json_field: "value",
      nested_value:
        Class.new(Struct.new(:field)) do
          include SBOM::CycloneDX::SchemaObject
          def valid?
            true
          end
        end.new(field: "nested")
    }
  end
  let(:expected_json_compatible_hash) do
    {
      "stringField" => "string",
      "integerField" => 1,
      "floatField" => 2.5,
      "booleanField" => true,
      "datetimeField" => "2024-10-14T17:24:33.000+00:00",
      "uriField" => "https://example.com",
      "emailAddressField" => "test@example.com",
      "arrayField" => ["value1", 2, true],
      "special-json-field" => "value",
      "nestedValue" => { "field" => "nested" }
    }
  end
  let(:expected_json) do
    "{" \
      '"stringField":"string",' \
      '"integerField":1,' \
      '"floatField":2.5,' \
      '"booleanField":true,' \
      '"datetimeField":"2024-10-14T17:24:33.000+00:00",' \
      '"uriField":"https://example.com",' \
      '"emailAddressField":"test@example.com",' \
      '"arrayField":["value1",2,true],' \
      '"special-json-field":"value",' \
      '"nestedValue":{"field":"nested"}' \
      "}"
  end

  let(:schema_object) do
    Class.new(Struct.new(*field_values.keys)) do
      include SBOM::CycloneDX::SchemaObject

      json_name :special_json_field, "special-json-field"

      def valid?
        true
      end
    end.new(**field_values)
  end

  describe "#as_json" do
    subject(:json_hash) { schema_object.as_json }

    it "transforms keys into lowerCamelCase by default" do
      expect(json_hash.key?("stringField")).to be true
    end

    it "transforms keys as-specified when a json_name is provided" do
      expect(json_hash.key?("special-json-field")).to be true
    end

    it "transforms values into JSON-compatible types" do
      expect(json_hash).to include("datetimeField" => String, "uriField" => String, "emailAddressField" => String)
    end

    it "returns a JSON-compatible representation of the object" do
      expect(json_hash).to eq(expected_json_compatible_hash)
    end
  end

  describe "#to_json" do
    it "returns a JSON representation of the object" do
      expect(schema_object.to_json).to eq(expected_json)
    end
  end

  describe "#valid?" do
    # Check actual validation logic in validator tests
    it "returns true" do
      expect(schema_object.valid?).to be true
    end
  end

  describe "::valid?" do
    it "delegates to the Validator" do
      allow(SBOM::CycloneDX::Validator).to receive(:valid?)
      schema_object.class.valid?(schema_object)
      expect(SBOM::CycloneDX::Validator)
        .to have_received(:valid?).with(schema_object.class, schema_object, required: false)
    end
  end

  context "when not used correctly" do
    it "raises an error when included in a non-Struct class" do
      expect do
        Class.new { include SBOM::CycloneDX::SchemaObject }
      end.to raise_error(ArgumentError, "SchemaObject must be included in a Struct")
    end

    it "raises an error when ClassMethods are extended by a non-SchemaObject class" do
      expect do
        Class.new(Struct.new(:field)) { extend SBOM::CycloneDX::SchemaObject::ClassMethods }
      end.to raise_error(ArgumentError, "This module can only be extended by a SchemaObject")
    end

    it "raises an error when calling valid? on a class that did not override it" do
      expect do
        Class.new(Struct.new(:field)) { include SBOM::CycloneDX::SchemaObject }.new.valid?
      end.to raise_error(NotImplementedError, "valid? must be implemented by the concrete class")
    end
  end
end
