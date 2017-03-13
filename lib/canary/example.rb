require 'forwardable'

module Canary

  # Simple data class to represent an rspec example based on rspec's `output_hash`
  class Example

    extend Forwardable

    include Virtus.model

    attribute :description, String
    attribute :full_description, String
    attribute :status, String
    attribute :file_path, String
    attribute :line_number, Integer
    attribute :run_time, Float
    attribute :pending_message, String
    attribute :exception, Canary::Exception

    def passed?
      status == 'passed'
    end

    def failed?
      status == 'failed'
    end

    def pass_count
      passed? ? 1 : 0
    end

    def fail_count
      failed? ? 1 : 0
    end

    def app_name
      @app_name ||= file_path[VENDOR_SPEC_PATH_REGEX, 1]
    end

    def app
      @app ||= Canary.apps.detect { |app| app.name == app_name }
    end

    def_delegators :app, :url, :cluster

  end

end
