# frozen_string_literal: true

require "spec_helper"

describe SBOM::CycloneDX::Field do
  describe SBOM::CycloneDX::Field::Base do
    describe "#initialize" do
      it "raises an error if instantiated directly"
    end

    describe "#value"
    describe "#valid?"
    describe "convenience methods"

    context "with the singleton class" do
      describe "#field_name" do
        it "returns the defined field name"
      end

      describe "#validator"
      describe "#json_name"
      describe "#required?"
      describe "#const"
      describe "#const?"
      describe "#default"
      describe "#default?"
    end
  end

  describe SBOM::CycloneDX::Field::ConstBase do
    describe "#initialize" do
      it "raises an error if instantiated directly"
      it "sets the value to the class' #const value"
    end
  end

  describe SBOM::CycloneDX::Field::PropBase do
    describe "#initialize" do
      it "raises an error if instantiated directly"
      it "requires exactly zero or one argument"

      context "with no argument" do
        it "calls unset_value"
      end

      context "with one argument" do
        it "calls value= with the argument"
      end
    end

    describe "#value=" do
      context "when the argument is nil" do
        context "when required and default exists" do
          it "sets the value to default"
          it "sets the value presence to true"
        end

        context "when required an no default exists" do
          it "sets the value to nil"
          it "sets the value presence to false"
        end

        context "when not required" do
          it "sets the value to nil"
          it "sets the value presence to true"
        end
      end

      context "when the argument is not nil" do
        it "sets the value to the argument"
        it "sets the value presence to true"
      end
    end

    describe "#unset_value" do
      context "when a default value exists" do
        it "sets the value to the default"
        it "sets the value presence to true"
      end

      context "when no default value exists" do
        it "sets the value to nil"
        it "sets the value presence to false"
      end
    end

    describe "#coerce" do
      it "raises a NotImplementedError if not overridden"
    end
  end

  describe "#array"
  describe "#boolean"
  describe "#date_time"
  describe "#email_address"
  describe "#float"
  describe "#integer"
  describe "#record"
  describe "#string"
  describe "#union"
  describe "#uri"

  # TODO: Add some shared test logic for the considerable #Field and #validate_types methods
end
