require 'aws-sdk'

module Canary

  module Notifiers

    # Callable class to notify CloudWatch for all metrics within an rspec run
    class CloudWatch

      extend Callable

      attr_accessor :run, :client

      def initialize(run:, client: Aws::CloudWatch::Client.new)
        @run = run
        @client = client
      end

      def call
        put_metric_data(run_metric_data)

        run.examples.group_by(&:app_name).each do |app_name, examples|
          put_metric_data(app_metric_data(app_name, examples))

          examples.each do |example|
            put_metric_data(example_metric_data(app_name, example))
          end
        end
      end

      def run_metric_data
        CloudWatchMetricData.call(run.pass_count, run.fail_count)
      end

      def app_metric_data(app_name, examples)
        dimensions = [
          { name: 'App', value: app_name },
          { name: 'AppCluster', value: Canary.config.fetch("#{app_name}_cluster") }
        ]
        pass_count = examples.select(&:passed?).length
        fail_count = examples.select(&:failed?).length

        CloudWatchMetricData.call(pass_count, fail_count, dimensions)
      end

      def example_metric_data(app_name, example)
        dimensions = [
          { name: 'App', value: app_name },
          { name: 'AppCluster', value: Canary.config.fetch("#{app_name}_cluster") },
          { name: 'Description', value: example.full_description }
        ]
        CloudWatchMetricData.call(example.pass_count, example.fail_count, dimensions)
      end

      def put_metric_data(metric_data)
        response = client.put_metric_data(namespace: 'Canary', metric_data: metric_data)
        raise unless response.successful?
      end

    end

  end

end
