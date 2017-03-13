require 'spec_helper'

RSpec.describe Canary::Config do
  subject(:config) { Canary.config }

  let(:cluster) { 'k2' }
  let(:app) { 'google' }
  let(:google_url) { 'https://google.com' }

  let(:env_vars) do
    {
      'CANARY_CLUSTER' => cluster,
      'CANARY_GOOGLE_URL' => google_url
    }
  end
  include_context 'stub env'

  describe '.fetch' do
    context 'existing config var' do
      it 'fetches a config var' do
        expect(config.fetch("#{app}_url")).to eq(google_url)
      end
    end

    context 'missing config var' do
      it 'raises a meaningful error' do
        expect { config.fetch('snoop') }.to raise_error(
          RuntimeError,
          /CANARY_SNOOP is not set in ENV/
        )
      end
    end
  end

  describe '.method_missing' do
    it 'returns a config var' do
      expect(config.cluster).to eq(cluster)
    end
  end

  describe '.respond_to?' do
    it 'is true for existing environment variable' do
      expect(config.respond_to?(:cluster)).to be(true)
    end

    it 'is false for non-existing environment variable' do
      expect(config.respond_to?(:foo)).to be(false)
    end
  end
end
