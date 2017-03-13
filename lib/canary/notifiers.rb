require 'rspec'

module Canary

  # Single point of entry to call all Canary notifiers
  module Notifiers

    def self.call(run)
      return unless Canary.config.respond_to?(:notifiers)
      notifiers.map do |notifier|
        notifier.call(run: run)
      end
    end

    def self.notifiers
      Canary.config.notifiers.split(',').map do |notifier|
        klass(notifier)
      end
    end

    def self.klass(notifier)
      klass_name = notifier.split('_').map(&:capitalize).join('')
      Kernel.const_get("Canary::Notifiers::#{klass_name}")
    end

  end

end
