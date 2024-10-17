# frozen_string_literal: true

require "faker"

module FactoryHelper
  SEQUENCE_GENERATORS = {
    # Generators for data not available through Faker, mostly matching Pattern:: constants
    cdx_urn_fragment: ->(n) { "fragment-#{n}" },
    cdx_bom_version: ->(n) { (n + 1).to_s },
    cdx_urn_nss: ->(n) { "#{SecureRandom.uuid}/#{use_generator(:cdx_bom_version).call(n)}" },
    cdx_urn_assigned_name: ->(n) { "urn:cdx:#{use_generator(:cdx_urn_nss).call(n)}" },
    cdx_urn_with_fragment: lambda do |n|
      "#{use_generator(:cdx_urn_assigned_name).call(n)}##{use_generator(:cdx_urn_fragment).call(n)}"
    end,
    cdx_urn: lambda do |n|
      next use_generator(:cdx_urn_assigned_name).call(n) if Faker::Boolean.boolean

      use_generator(:cdx_urn_with_fragment).call(n)
    end,
    bom_serial_number: ->(_) { "urn:uuid:#{SecureRandom.uuid}" },
    ref_link: ->(n) { "ref-link-#{n}" },
    ref_or_cdx_urn: lambda do |n|
      Faker::Boolean.boolean ? use_generator(:ref_link).call(n) : use_generator(:cdx_urn_with_fragment).call(n)
    end,
    hash_value: ->(_) { SecureRandom.hex([32, 40, 64, 96, 128].sample) },
    locale: ->(_) { I18n.available_locales.sample.to_s },
    mime_type: ->(_) { Faker::File.mime_type },
    open_cre: ->(_) { "CRE:#{rand(1..100)}-#{rand(1..100)}" },
    content_type: lambda do |n|
      mime_type = use_generator(:mime_type).call(n)
      next mime_type if Faker::Boolean.boolean

      "#{mime_type}; #{Faker::Lorem.word.downcase}=#{Faker::Lorem.word.downcase}-#{n}"
    end,
    url: lambda do |_|
      next Faker::Internet.url if Faker::Boolean.boolean

      URI.parse(Faker::Internet.url)
    end
  }.freeze

  def self.use_generator(name)
    SEQUENCE_GENERATORS[name]
  end

  def self.create_generators_on(factory)
    SEQUENCE_GENERATORS.each_key do |name|
      factory.send(:sequence, name, &use_generator(name))
    end
  end
end
