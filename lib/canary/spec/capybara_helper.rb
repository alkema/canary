require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.run_server = false

# Helps when there is slow execution of onload scripts
Capybara.default_max_wait_time = Canary::WAIT_TIME

Capybara.register_driver :poltergeist do |app|
  phantomjs_logger = Canary.config.env == 'development' ? Logger.new('/dev/null') : STDOUT
  options = {
    phantomjs_logger: phantomjs_logger,
    js_errors: false,
    timeout: Canary::WAIT_TIME # Helps a page with assets loading slowly
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.default_driver = :poltergeist

Capybara.javascript_driver = :poltergeist
