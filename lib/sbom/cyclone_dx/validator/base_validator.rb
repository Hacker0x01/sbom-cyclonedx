# frozen_string_literal: true

module SBOM
  module CycloneDX
    # TODO: Add helpful errors
    module Validator
      class BaseValidator
        REDEFINED_CONST = "Cannot redefine a constant property"
        MISSING_REQUIRED = "Required property is missing or nil"
        INVALID_TYPE = "Invalid type `%s`, expected: %s"

        def initialize(required: false, **kwargs)
          @defined_as_const = kwargs.key?(:const)
          parse_kwargs(**kwargs)
          @required = required
          @errors = []
        end

        def valid?(value, *klasses)
          validate(value, *klasses)
          @errors.empty?
        end

        def validate(value, *klasses)
          @errors = []

          @errors << REDEFINED_CONST if @defined_as_const
          @errors << MISSING_REQUIRED if @required && value.nil?
          return @errors if @errors.any?
          return @errors if klasses.any? { |klass| value.is_a?(klass) }

          @errors << format(INVALID_TYPE, value.class.name, klasses.join(", "))
        end

        def required?
          @required
        end

        def const?
          @defined_as_const
        end

        private

        def parse_kwargs(const: nil, **extra_args)
          raise ArgumentError, "Unknown keyword arguments: #{extra_args.keys.join(", ")}" if extra_args.any?
          return unless @defined_as_const

          @const = const
        end
      end
    end
  end
end
