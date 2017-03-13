require 'spec_helper'

RSpec.describe Canary::Example do
  include_context 'stub app names'

  let(:example_hash) { examples.first }

  subject(:example) { described_class.new(example_hash) }

  let(:app_name) { 'google' }
  let(:app_cluster) { 'awesome' }
  let(:app_url) { 'https://google.com' }

  let(:env_vars) do
    {
      'CANARY_CLUSTER' => 'foo',
      'CANARY_GOOGLE_CLUSTER' => app_cluster,
      'CANARY_GOOGLE_URL' => app_url
    }
  end
  include_context 'stub env'

  context 'passing example' do
    include_context 'passing output hash'

    let(:file_path_line_number) { './lib/canary/spec/google/features/sign_in_spec.rb#L9' }

    it 'is passed' do
      expect(example.passed?).to be(true)
    end

    it 'is not failed' do
      expect(example.failed?).to be(false)
    end

    it 'has a valid pass count' do
      expect(example.pass_count).to eq(1)
    end

    it 'has a valid fail count' do
      expect(example.fail_count).to eq(0)
    end

    it 'extracts app name' do
      expect(example.app_name).to eq(app_name)
    end

    it 'extracts app' do
      expect(example.app).to have_attributes(
        name: app_name,
        url: app_url,
        cluster: app_cluster
      )
    end
  end

  context 'failing example' do
    include_context 'failing output hash'

    it 'is not passed' do
      expect(example.passed?).to be(false)
    end

    it 'is failed' do
      expect(example.failed?).to be(true)
    end

    it 'has a valid pass count' do
      expect(example.pass_count).to eq(0)
    end

    it 'has a valid fail count' do
      expect(example.fail_count).to eq(1)
    end
  end
end
