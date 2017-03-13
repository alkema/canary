require 'bundler/setup'
require 'dotenv'
Dotenv.load('.env.test')

require 'byebug'
require 'climate_control'
require 'canary'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.order = :random

  config.color = true

  config.tty = true

  Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
end
