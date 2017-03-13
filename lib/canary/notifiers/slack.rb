require 'slack-notifier'

module Canary

  module Notifiers

    # Notifier class to send a collection of failed examples to Slack as attachments
    class Slack

      extend Callable

      attr_accessor :run, :client

      def initialize(run:, client: ::Slack::Notifier.new(Canary.config.slack_webhook_url))
        @run = run
        @client = client
      end

      def call
        return unless run.failed?

        attachments =
          run.failed_examples.map do |example|
            SlackAttachment.call(example)
          end

        client.ping("attachments": attachments)
      end

    end

  end

end
