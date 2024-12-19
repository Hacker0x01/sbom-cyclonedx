# frozen_string_literal: true

require_relative("base_validator")
require_relative("record_validator")
require_relative("../validator")

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class ArrayValidator < BaseValidator
        def initialize(items:, unique: false, required: false)
          super(Array, required: required)

          @unique = unique
          @items_validator =
            case items
            when :array, :boolean, :date_time, :email_address, :float, :integer, :string, :uri
              validator_method(Validator.for(items, required: true))
            when Proc
              proc_validator(items)
            when Array
              validator_method(Validator.for(items.first, required: true, **items.last))
            when Class
              raise "Unsupported items type: #{items}" unless items < Record::Base

              validator_method(RecordValidator.new(type: items, required: true))
            else
              raise ArgumentError, "Unsupported items type: #{items}"
            end
        end

        def validate(value)
          rv = super
          return rv unless value.is_a?(Array)

          rv << "Unique array contains non-unique values" if @unique && value.uniq.length != value.length
          value.each { |item| rv += @items_validator.call(item) }
          rv
        end

        private

        def validator_method(klass)
          proc { |item| klass.validate(item) } #: ^(untyped) -> Array[String]
        end

        def proc_validator(validator)
          lambda do |item|
            rv = validator.call(item)
            case rv
            when Array then rv.map(&:to_s)
            when true then []
            when false then ["#{item} is invalid"]
            else [rv.to_s]
            end
          end
        end
      end
    end
  end
end
