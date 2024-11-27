# frozen_string_literal: true

require_relative "field/array"
require_relative "field/base"
require_relative "field/boolean"
require_relative "field/date_time"
require_relative "field/email_address"
require_relative "field/float"
require_relative "field/integer"
require_relative "field/record"
require_relative "field/string"
require_relative "field/union"
require_relative "field/uri"

module SBOM
  module CycloneDX
    module Field
      NOT_SET = Data.define.new.freeze

      def self.for(type, name, **kwargs) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength
        case type
        when :array then Array.new(name: name, items: kwargs.fetch(:items), **kwargs)
        when :boolean then Boolean.new(name: name, **kwargs)
        when :date_time then DateTime.new(name: name, **kwargs)
        when :email_address then EmailAddress.new(name: name, **kwargs)
        when :float then Float.new(name: name, **kwargs)
        when :integer then Integer.new(name: name, **kwargs)
        when Class then Record.new(name: name, type: type, **kwargs)
        when :string then String.new(name: name, **kwargs)
        when :union then Union.new(name: name, of: kwargs.fetch(:of), **kwargs)
        when :uri then URI.new(name: name, **kwargs)
        else raise "unknown field type: #{type}"
        end
      end
    end
  end
end
