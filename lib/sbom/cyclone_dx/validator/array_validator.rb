# frozen_string_literal: true

require_relative("base_validator")
require_relative("record_validator")
require_relative("../validator")

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class ArrayValidator < BaseValidator
        def initialize(items:, unique: false, required: false, **kwargs)
          super(required: required, **kwargs)

          @unique = unique
          @items_validator =
            case items
            when Proc
              items
            when Array
              ->(item) { Validator.for(items.first, required: true, **items.last).valid?(item) }
            when Class
              ->(item) { RecordValidator.new(type: items, required: true).valid?(item) }
            else
              ->(item) { Validator.for(items, required: true).valid?(item) }
            end
        end

        def valid?(value)
          return false unless super(value, Array)

          value.is_a?(Array) &&
            (!@unique || value.uniq.length == value.length) &&
            value.all? do |item|
              @items_validator.call(item)
            end
        end
      end
    end
  end
end
