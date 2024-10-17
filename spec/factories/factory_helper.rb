# frozen_string_literal: true

require "faker"

module FactoryHelper
  SEQUENCE_GENERATORS = {
    # Generators for data not available through Faker, mostly matching Pattern:: constants
    cdx_urn_fragment: ->(n) { "fragment-#{n}" },
    cdx_bom_version: ->(n) { (n + 1).to_s },
    cdx_urn_nss: ->(n) { "#{SecureRandom.uuid}/#{use_generator(:cdx_bom_version, n)}" },
    cdx_urn_assigned_name: ->(n) { "urn:cdx:#{use_generator(:cdx_urn_nss, n)}" },
    cdx_urn_with_fragment: lambda do |n|
      "#{use_generator(:cdx_urn_assigned_name, n)}##{use_generator(:cdx_urn_fragment, n)}"
    end,
    cdx_urn: lambda do |n|
      next use_generator(:cdx_urn_assigned_name, n) if Faker::Boolean.boolean

      use_generator(:cdx_urn_with_fragment, n)
    end,
    bom_serial_number: ->(_) { "urn:uuid:#{SecureRandom.uuid}" },
    ref_link: ->(n) { "ref-link-#{n}" },
    ref_or_cdx_urn: lambda do |n|
      Faker::Boolean.boolean ? use_generator(:ref_link, n) : use_generator(:cdx_urn_with_fragment, n)
    end,
    hash_value: ->(_) { SecureRandom.hex([32, 40, 64, 96, 128].sample) },
    locale: ->(_) { I18n.available_locales.sample.to_s },
    mime_type: ->(_) { Faker::File.mime_type },
    open_cre: ->(_) { "CRE:#{rand(1..100)}-#{rand(1..100)}" },
    content_type: lambda do |n|
      mime_type = use_generator(:mime_type, n)
      next mime_type if Faker::Boolean.boolean

      "#{mime_type}; #{Faker::Lorem.word.downcase}=#{Faker::Lorem.word.downcase}-#{n}"
    end,
    url: lambda do |_|
      next Faker::Internet.url if Faker::Boolean.boolean

      URI.parse(Faker::Internet.url)
    end
  }.freeze

  SEQUENCE_GENERATORS.each do |name, generator|
    FactoryBot::Internal.register_sequence(FactoryBot::Sequence.new(name, &generator))
  end

  def self.use_generator(name, n) # rubocop:disable Naming/MethodParameterName
    SEQUENCE_GENERATORS.fetch(name).call(n)
  end

  def generate_association(factories, *args, **kwargs)
    association(factories.sample, *args, **kwargs)
  end

  def association_list(factory, count, *args, **kwargs)
    Array.new(count) { generate_association(Array(factory), *args, **kwargs) }
  end

  def generate_license_choice(*args, **kwargs)
    generate_association(%i[license_expression wrapped_license], *args, **kwargs)
  end

  def license_choice_list(count, *args, **kwargs)
    association_list(%i[license_expression wrapped_license], count, *args, **kwargs)
  end

  def generate_signature(*args, **kwargs)
    generate_association(%i[jsf_signature signature_chain signer_list], *args, **kwargs)
  end
end

FactoryBot::Evaluator.prepend(FactoryHelper)
