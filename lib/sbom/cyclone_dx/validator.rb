# frozen_string_literal: true

require_relative "schema_object"
require_relative "../cyclone_dx"

module SBOM
  module CycloneDX
    module Validator
      # TODO: Add helpful errors
      class << self
        # NOTE: Some "types" are more-strict than others. For example, the `URI` and `EmailAddress` types
        #       allow both strings and their respective classes. When a string is provided, it is validated
        #       by the class, but kept as a String. This is to allow for better usability of this gem.
        #       DateTime _must_ be a DateTime object, and not a string.
        def valid?(klass, object, required: false, **type_specific_args) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength
          return false if object.nil? && required
          return true if type_specific_args[:const] == object && object.is_a?(klass)

          return valid_string?(object, **type_specific_args) if klass == String
          return valid_integer?(object, **type_specific_args) if klass == Integer
          return valid_float?(object, **type_specific_args) if klass == Float
          return valid_boolean?(object, **type_specific_args) if klass == Boolean
          return valid_schema_object?(klass, object, **type_specific_args) if klass < SchemaObject
          return valid_array?(object, items: type_specific_args.delete(:items), **type_specific_args) if klass == Array

          return object.is_a?(DateTime) if klass == DateTime
          return object.is_a?(URI::HTTP) || valid_string?(object, format: :uri) if klass == URI

          if klass == Union
            return valid_union?(object, klasses: type_specific_args.delete(:klasses), **type_specific_args)
          end

          if klass == EmailAddress::Address
            return (object.is_a?(EmailAddress::Address) && object.valid?) || valid_string?(object, format: :email)
          end

          raise ArgumentError, "Unsupported type: #{klass}"
        end

        private

        def valid_string?(object, enum: nil, format: nil, max_length: nil, min_length: nil, pattern: nil, **_extra_args) # rubocop:disable Metrics/ParameterLists,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
          return false unless object.is_a?(String)

          valid_format = case format
                         when :uri then URI.parse(object).is_a?(URI::HTTP)
                         when :email then EmailAddress.valid?(object)
                         else true
                         end

          (enum.nil? || enum.include?(object)) &&
            valid_format &&
            (max_length.nil? || object.length <= max_length) &&
            (min_length.nil? || object.length >= min_length) &&
            (pattern.nil? || object.match?(pattern))
        end

        def valid_integer?(object, maximum: nil, minimum: nil, **_extra_args)
          object.is_a?(Integer) && valid_numeric?(object, maximum: maximum, minimum: minimum)
        end

        def valid_float?(object, maximum: nil, minimum: nil, **_extra_args)
          object.is_a?(Float) && valid_numeric?(object, maximum: maximum, minimum: minimum)
        end

        def valid_numeric?(object, maximum: nil, minimum: nil)
          (maximum.nil? || object <= maximum) && (minimum.nil? || object >= minimum)
        end

        def valid_boolean?(object, **_extra_args)
          object.is_a?(TrueClass) || object.is_a?(FalseClass)
        end

        # TODO: Avoid circular references
        def valid_schema_object?(klass, object, **_extra_args)
          object.is_a?(klass) && object.valid?
        end

        # NOTE: Items in arrays are _required_ (not nilable) by default
        #       This can be overridden by setting the `required` key in the items args
        #       Empty arrays are allowed by default
        def valid_array?(object, items:, unique: false, **_extra_args) # rubocop:disable Metrics/CyclomaticComplexity
          object.is_a?(Array) &&
            (!unique || object.uniq.length == object.length) &&
            object.all? do |item|
              next items.call(item) if items.is_a?(Proc)
              next valid?(items, item, required: true) unless items.is_a?(Array)

              items_klass, items_args = items
              required = items_args.key?(:required) ? items_args.delete(:required) : true

              valid?(items_klass, item, required: required, **items_args)
            end
        end

        def valid_union?(object, klasses:, **type_specific_args)
          klasses.any? { |klass| valid?(klass, object, **type_specific_args) }
        end
      end
    end
  end
end
