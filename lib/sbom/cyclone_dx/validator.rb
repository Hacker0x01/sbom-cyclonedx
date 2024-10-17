# frozen_string_literal: true

require "active_support/all"
require "date"
require "uri"
require_relative "schema_object"
require_relative "../cyclone_dx"

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class << self
        # NOTE: Some "types" are more-strict than others. For example, the `DateTime`, `URI` and `EmailAddress` types
        #       allow both strings and their respective classes. When a string is provided, it is validated by the
        #       class, but kept as a String. This is to allow for better usability of this gem.
        def valid?(klass, object, required: false, **kwargs) # rubocop:disable Metrics/PerceivedComplexity
          if kwargs.key?(:const)
            return valid_const?(klass, object, const: kwargs.delete(:const), required: required, **kwargs)
          end
          return !required if object.nil?

          # It is not possible to do a case/switch on a class, so we have to do it on the class name
          case klass.to_s
          when "Array"
            raise ArgumentError, ":items must be provided for array validation" unless kwargs.key?(:items)

            valid_array?(object, items: kwargs.delete(:items), **kwargs)
          when "DateTime" then valid_datetime?(object)
          when "Float" then valid_float?(object, **kwargs)
          when "Integer" then valid_integer?(object, **kwargs)
          when "String" then valid_string?(object, **kwargs)
          when "URI" then valid_uri?(object)
          when "SBOM::CycloneDX::Type::Boolean" then valid_boolean?(object, **kwargs)
          when "SBOM::CycloneDX::EmailAddress" then valid_email?(object)
          when "SBOM::CycloneDX::Type::Union"
            raise ArgumentError, ":klasses must be provided for union validation" unless kwargs.key?(:klasses)

            valid_union?(object, klasses: kwargs.delete(:klasses), **kwargs)
          when /\ASBOM::CycloneDX::/
            raise ArgumentError, "Unsupported type: #{klass}" unless klass < SchemaObject

            valid_schema_object?(klass, object, **kwargs)
          else raise ArgumentError, "Unsupported type: #{klass}"
          end
        end

        private

        def valid_const?(klass, object, const:, required:, **kwargs)
          # Really, this should be checked only once, but it's not worth the complexity right now
          unless const.is_a?(klass) || valid?(klass, const, required: required, **kwargs)
            raise ArgumentError, "const value has wrong type: #{const.class}"
          end

          const == object
        end

        def valid_string?(object, enum: nil, max_length: nil, min_length: nil, pattern: nil, **_kwargs) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
          return false unless object.is_a?(String)

          (enum.nil? || enum.include?(object)) &&
            (max_length.nil? || object.length <= max_length) &&
            (min_length.nil? || object.length >= min_length) &&
            (pattern.nil? || object.match?(pattern))
        end

        def valid_datetime?(object)
          return true if object.is_a?(DateTime) || object.is_a?(Time)
          return false unless valid_string?(object)

          parsed = DateTime.parse(object)
          parsed.is_a?(DateTime) && parsed.iso8601 == object
        rescue Date::Error
          false
        end

        def valid_uri?(object)
          object.is_a?(URI::HTTP) || (valid_string?(object) && URI.parse(object).is_a?(URI::HTTP))
        end

        def valid_email?(object)
          (object.is_a?(SBOM::CycloneDX::EmailAddress) && object.valid?) ||
            (valid_string?(object) && SBOM::CycloneDX::EmailAddress.valid?(object))
        end

        def valid_integer?(object, maximum: nil, minimum: nil, **_kwargs)
          object.is_a?(Integer) && valid_numeric?(object, maximum: maximum, minimum: minimum)
        end

        def valid_float?(object, maximum: nil, minimum: nil, **_kwargs)
          object.is_a?(Float) && valid_numeric?(object, maximum: maximum, minimum: minimum)
        end

        def valid_numeric?(object, maximum: nil, minimum: nil)
          (maximum.nil? || object <= maximum) && (minimum.nil? || object >= minimum)
        end

        def valid_boolean?(object, **_kwargs)
          object.is_a?(TrueClass) || object.is_a?(FalseClass)
        end

        # TODO: Avoid circular references
        def valid_schema_object?(klass, object, **_kwargs)
          object.is_a?(klass) && object.valid?
        end

        # NOTE: Items in arrays are _required_ (not nilable) by default
        #       This can be overridden by setting the `required` key in the items args
        #       Empty arrays are allowed by default
        def valid_array?(object, items:, unique: false, **_kwargs) # rubocop:disable Metrics/CyclomaticComplexity
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

        def valid_union?(object, klasses:, **kwargs)
          if klasses.blank?
            raise ArgumentError,
                  "Union type requires klasses, but received object: #{object}, klasses: #{klasses.inspect}"
          end

          klasses.any? { |klass| valid?(klass, object, **kwargs) }
        end
      end
    end
  end
end
