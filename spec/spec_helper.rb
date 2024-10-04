# frozen_string_literal: true

require "sbom/cyclone_dx"
require "factory_bot"
require "rspec"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = ".rspec_state"
  config.disable_monkey_patching!
  config.expose_dsl_globally = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
    config.warnings = true
  else
    config.profile_examples = 10
  end

  config.order = :random
  Kernel.srand config.seed

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
