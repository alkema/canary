require 'aws-sdk'

module Canary

  module Notifiers

    # Common interface to build a standard AWS metric data data structure
    class CloudWatchMetricData

      extend Callable

      attr_accessor :pass_count, :fail_count, :dimensions

      def initialize(pass_count, fail_count, dimensions = [])
        @dimensions = dimensions.unshift(name: 'Cluster', value: Canary.config.cluster)
        @pass_count = pass_count
        @fail_count = fail_count
      end

      # rubocop:disable Metrics/MethodLength
      def call
        [
          {
            dimensions: dimensions,
            metric_name: 'PassCount',
            value: pass_count,
            unit: 'Count'
          },
          {
            dimensions: dimensions,
            metric_name: 'FailCount',
            value: fail_count,
            unit: 'Count'
          }
        ]
      end

    end

  end

end
