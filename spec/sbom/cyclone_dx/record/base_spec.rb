# frozen_string_literal: true

require "spec_helper"

describe SBOM::CycloneDX::Record::Base do
  context "with singleton class" do
    describe "#fields" do
      it "returns a Hash of Fields"
    end

    describe "#json_create" do
      it "creates a new instance of the class from a JSON representation"
    end

    describe "#json_name" do
      context "when called with an argument" do
        it "sets the JSON name for the class if called within the class body"
        it "raises an error if called outside the class body"
      end

      context "when called without an argument" do
        it "returns the JSON name for the class if one was set"
        it "returns the bare class name if no JSON name was set"
        it "returns 'Record' if no JSON name was set and the class name is nil"
      end
    end

    describe "#prop" do
      it "raises an error if called outside the class body"
      it "raises an error if called on the abstract class"
      it "raises an error if a property is defined more than once"
      it "creates a new field with the specified name and type"
      it "accepts the :required flag"
      it "accepts additional type-specific options"
      it "defines a getter method for the property"
      it "defines a setter method for non-const properties"
      it "does not define a setter method for const properties"
      it "defines a predicate method for the property with a '?' suffix"
      it "defines a _valid? method for the property"
    end

    describe "#const" do
      it "is syntactic sugar for prop with :const value"
    end

    describe "#validate" do
      it "raises an error if called outside the class body"
      it "raises an error if called on the abstract class"
      it "raises an error if provided with both :presence option and a block"
      it "accepts presence validtaion with :all, :any, or :one"
      it "accepts a block for running custom validations"
    end
  end

  describe "#initialize" do
    context "when called on the abstract class" do
      it "raises an error when instantiated"
    end

    context "when called on a subclass" do
      it "does not raise an error when instantiated"
      it "populates fields with provided values"
      it "populates defaults when values are not provided"
      it "raises an error when a value is provided for a const field"
      it "raises an error when an unknown field is provided"
      it "checks validity of the record"
    end
  end

  describe "#<=>" do
    it "returns nil if records are not of the same type"
    it "returns 0 if all record fields match"
    it "returns non-zero if records differ"
    it "recursively compares nested records"
  end

  describe "#valid?" do
    it "returns true if all fields are valid"
    it "returns false if any field is invalid"
    it "runs presence validations"
    it "populates the errors hash"

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
