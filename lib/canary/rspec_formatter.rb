require 'rspec/core/formatters/json_formatter'

module Canary

  # Callable class to run all Canary acceptance specs
  class RspecFormatter

    def self.formatter
      setup_reporter(config)
    end

    def self.output_hash(formatter)
      formatter.output_hash
    end

    def self.config
      load FULL_SPEC_PATH.join('spec_helper.rb')
      load FULL_SPEC_PATH.join('capybara_helper.rb')
      load FULL_SPEC_PATH.join('support/capybara_app_host.rb')
      RSpec.configuration
    end

    def self.run(spec_path)
      RSpec::Core::Runner.run([FULL_SPEC_PATH.to_s, spec_path])
    end

    def self.setup_reporter(config)
      formatter = RSpec::Core::Formatters::JsonFormatter.new(config.output_stream)

      reporter = RSpec::Core::Reporter.new(config)
      # create reporter with json formatter
      config.instance_variable_set(:@reporter, reporter)

      loader = config.send(:formatter_loader)

      # internal hack
      # api may not be stable, make sure lock down Rspec version
      notifications = loader.send(:notifications_for, RSpec::Core::Formatters::JsonFormatter)
      reporter.register_listener(formatter, *notifications)
      formatter
    end

  end

end
