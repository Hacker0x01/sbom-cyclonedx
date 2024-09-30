# frozen_string_literal: true
# rbs_inline: enabled
module Sbom
  module Cyclonedx
    class SchemaObject
      # TODO: Implicit cast/convert/parse to non-JSON types (e.g. DateTime, URI, etc.) as-needed
      def initialize(**kwargs)
        assign_properties(defaults.merge(kwargs))
        errors = validate_properties(kwargs)

        raise ArgumentError if errors.any?
      end

      class << self
        protected

        def validate(name, **options)
          @validations ||= Hash.new { |h, k| h[k] = {} }
          @validations[name].merge(options)
        end

        def default(name, value)
          defaults[name] = value
        end

        private

        def defaults
          @defaults ||= {}
        end
      end

      private

      def assign_properties(properties)
        properties.each do |name, value|
          public_send("#{name}=", value)
        end
      end

      # Should use validation names/terms from JSON-Schema, with the addition of:
      # - `:required` for required properties
      # - `:all` for validating array contents
      def validate_properties(properties)
        errors = Hash.new { |h, k| h[k] = [] }

        properties.each do |name, value|
          error = validate_property(name, value)
          errors[name] << error if error
        end

        errors
      end
    end
  end
end
