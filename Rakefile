# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

namespace :rbs do
  desc "Validate RBS files"
  task :validate do
    require "rbs/cli"

    validate_args = ["validate"] + Dir.glob("sig").map { |dir| "-I #{dir}" }
    RBS::CLI.new(stdout: $stdout, stderr: $stderr).run(validate_args)
  end

  RSpec::Core::RakeTask.new(:spec) do |t|
    ENV.merge!(
      "RUBYOPT" => "#{ENV.fetch("RUBYOPT", "")} -r rbs/test/setup".strip, # Probably does nothing
      "RBS_TEST_RAISE" => "true",
      "RBS_TEST_LOGLEVEL" => "warn",
      "RBS_TEST_TARGET" => "\"SBOM::CycloneDX::*\""
    )
    require "rbs/test/setup"

    t.rspec_opts = "--tag '~rbs_test:skip'"
  end

  task test: %i[validate spec]
end
