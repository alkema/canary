require 'rspec/core/formatters/json_formatter'

module Canary

  # Callable class to run all Canary acceptance specs
  class Runner

    extend Callable

    attr_accessor :formatter, :spec_path

    def initialize(spec_path)
      @spec_path = spec_path
      @formatter = Canary::RspecFormatter.formatter
    end

    def call
      Canary::RspecFormatter.run(spec_path)
      output_hash = Canary::RspecFormatter.output_hash(formatter)
      run = Run.new(output_hash)
      Notifiers.call(run)
      run
    end

  end

end
