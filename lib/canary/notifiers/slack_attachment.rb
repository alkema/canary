require 'slack-notifier'

module Canary

  module Notifiers

    # Class to build a Slack attachment from an rspec example
    class SlackAttachment

      extend Callable

      attr_accessor :example

      def initialize(example)
        @example = example
      end

      def call
        {
          'pretext': pretext,
          'text': text,
          'fields': fields,
          'color': color,
          'mrkdwn_in': %w(text pretext)
        }
      end

      def pretext
        "#{example.status.capitalize} _Canary_ spec for *#{example.app_name}* on *#{example.url}*"
      end

      def text
        "_*#{example.full_description}*_"
      end

      def short_fields
        {
          'Source cluster' => Canary.config.cluster,
          'Target cluster' => example.cluster
        }
      end

      def long_fields
        {
          'File path' => example.file_path.to_s,
          'Exception' => example&.exception&.message
        }.compact
      end

      def transform_fields(hash, short = true)
        hash.map do |key, value|
          {
            "title": key,
            "value": value,
            "short": short
          }
        end
      end

      def fields
        transform_fields(short_fields) +
          transform_fields(long_fields, false)
      end

      def color
        example.failed? ? '#b20000' : '#009900'
      end

    end

  end

end
