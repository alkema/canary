require 'spec_helper'

RSpec.describe Canary::Notifiers::CloudWatch do
  include_context 'passing output hash'
  include_context 'stub rspec formatter'

  let(:run) { Canary::Run.new(output_hash) }
  let(:client) { Aws::CloudWatch::Client.new(stub_responses: true) }
  subject(:cloud_watch) { described_class.new(run: run, client: client) }

  let(:cluster) { 'cool' }

  let(:app_name) { 'google' }
  let(:app_cluster) { 'awesome' }
  let(:app_url) { 'https://google.com' }

  let(:env_vars) do
    {
      'CANARY_CLUSTER' => cluster,
      'CANARY_GOOGLE_CLUSTER' => app_cluster,
      'CANARY_GOOGLE_URL' => app_url
    }
  end
  include_context 'stub env'

  describe '.call' do
    # rubocop:disable Metrics/BlockLength
    it 'puts metric data' do
      expect(cloud_watch).to receive(:put_metric_data).once.with(
        [
          {
            dimensions: [
              { name: 'Cluster', value: cluster }
            ],
            metric_name: 'PassCount',
            value: 2,
            unit: 'Count'
          },
          {
            dimensions: [
              { name: 'Cluster', value: cluster }
            ],
            metric_name: 'FailCount',
            value: 0,
            unit: 'Count'
          }
        ]
      )

      expect(cloud_watch).to receive(:put_metric_data).once.with(
        [
          {
            dimensions: [
              { name: 'Cluster', value: cluster },
              { name: 'App', value: app_name },
              { name: 'AppCluster', value: app_cluster }
            ],
            metric_name: 'PassCount',
            value: 2,
            unit: 'Count'
          },
          {
            dimensions: [
              { name: 'Cluster', value: cluster },
              { name: 'App', value: app_name },
              { name: 'AppCluster', value: app_cluster }
            ],
            metric_name: 'FailCount',
            value: 0,
            unit: 'Count'
          }
          # Alarm for when prod app stops working regardless of which  instance
        ]
      )

      expect(cloud_watch).to receive(:put_metric_data).once.with(
        [
          {
            dimensions: [
              { name: 'Cluster', value: cluster },
              { name: 'App', value: app_name },
              { name: 'AppCluster', value: app_cluster },
              { name: 'Description', value: 'user signs in' }
            ],
            metric_name: 'PassCount',
            value: 1,
            unit: 'Count'
          },
          {
            dimensions: [
              { name: 'Cluster', value: cluster },
              { name: 'App', value: app_name },
              { name: 'AppCluster', value: app_cluster },
              { name: 'Description', value: 'user signs in' }
            ],
            metric_name: 'FailCount',
            value: 0,
            unit: 'Count'
          }
        ]

      )

      expect(cloud_watch).to receive(:put_metric_data).once.with(
        [
          {
            dimensions: [
              { name: 'Cluster', value: cluster },
              { name: 'App', value: app_name },
              { name: 'AppCluster', value: app_cluster },
              { name: 'Description', value: 'user signs out' }
            ],
            metric_name: 'PassCount',
            value: 1,
            unit: 'Count'
          },
          {
            dimensions: [
              { name: 'Cluster', value: cluster },
              { name: 'App', value: app_name },
              { name: 'AppCluster', value: app_cluster },
              { name: 'Description', value: 'user signs out' }
            ],
            metric_name: 'FailCount',
            value: 0,
            unit: 'Count'
          }
        ]
      )

      cloud_watch.call
    end
  end
end
