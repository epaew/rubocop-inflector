# frozen_string_literal: true

require 'bundler/setup'

require 'rubocop-rspec'
require 'rubocop-inflector'

require 'rubocop/rspec/support'

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  SimpleCov.start
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random

  # Forbid RSpec from monkey patching any of our objects
  config.disable_monkey_patching!

  # We should address configuration warnings when we upgrade
  config.raise_errors_for_deprecations!

  # RSpec gives helpful warnings when you are doing something wrong.
  # We should take their advice!
  config.raise_on_warning = true

  config.include(RuboCop::RSpec::ExpectOffense)

  begin
    # NOTE: This shared context was introduced in rubocop-rspec 2.15.0 and it requires Ruby >= 2.6.0
    require 'rubocop/rspec/shared_contexts/default_rspec_language_config_context'
    config.include_context 'with default RSpec/Language config', :config
  rescue
  end

  # Initialize ActiveSupport::Inflector
  config.before do
    ActiveSupport::Inflector.inflections.clear
  end
end
