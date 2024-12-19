# frozen_string_literal: true

Dir[File.join(".", "validator", "*.rb")].each { |file| require_relative file }

module SBOM
  module CycloneDX
    module Validator
      SIMPLE_TYPES = %i[boolean date_time email_address float integer string uri].freeze

      class << self
        def for(type, **kwargs) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/AbcSize
          case type
          when :array then ArrayValidator.new(items: kwargs.fetch(:items), **kwargs)
          when :boolean then BooleanValidator.new(**kwargs)
          when :date_time then DateTimeValidator.new(**kwargs)
          when :email_address then EmailAddressValidator.new(**kwargs)
          when :float then FloatValidator.new(**kwargs)
          when :integer then IntegerValidator.new(**kwargs)
          when :string then StringValidator.new(**kwargs)
          when :union then UnionValidator.new(of: kwargs.fetch(:of), **kwargs)
          when :uri then URIValidator.new(**kwargs)
          when Class
            raise ArgumentError, "Unsupported type: #{type.name}" unless type < Record::Base

            RecordValidator.new(type: type, **kwargs)
          else raise ArgumentError, "Unsupported type: #{type}"
          end
        end
      end
    end
  end
end
