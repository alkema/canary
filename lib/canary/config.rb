# Class to handle configuration
module Canary

  # Config class to allow for global Canary configuration
  class Config

    ENV_PREFIX = 'CANARY'.freeze

    def key?(key)
      ENV.key?(canary_key(key))
    end

    def fetch(key)
      key = canary_key(key)
      ENV.fetch(key) { raise "#{key} is not set in ENV" }
    end

    def method_missing(method_name, *arguments, &block)
      key?(method_name) ? fetch(method_name) : super
    end

    def respond_to_missing?(method_name, include_private = false)
      key?(method_name) || super
    end

    private

    def canary_key(key)
      "#{ENV_PREFIX}_#{key}".upcase
    end

  end

  class << self

    def config
      @config ||= Config.new
    end

  end

end
