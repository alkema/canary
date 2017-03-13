require 'spec_helper'

RSpec.describe Canary::Notifiers do
  include_context 'passing output hash'
  include_context 'stub rspec formatter'

  let(:run) { Canary::Run.new(output_hash) }

  let(:slack) { Canary::Notifiers::Slack }
  let(:cloud_watch) { Canary::Notifiers::CloudWatch }
  let(:klasses) { [slack, cloud_watch] }

  subject(:notifiers) { described_class }

  include_context 'stub env'

  describe '.call' do
    context 'with one notifier configured' do
      let(:env_vars) do
        {
          'CANARY_NOTIFIERS' => 'slack'
        }
      end

      it 'calls all notifiers' do
        expect(slack).to receive(:call).with(run: run)

        notifiers.call(run)
      end
    end

    context 'with two notifiers configured' do
      let(:env_vars) do
        {
          'CANARY_NOTIFIERS' => 'slack,cloud_watch'
        }
      end

      it 'calls all notifiers' do
        klasses.each do |klass|
          expect(klass).to receive(:call).with(run: run)
        end

        notifiers.call(run)
      end
    end

    context 'without notifiers configured' do
      let(:env_vars) do
        {
          'CANARY_NOTIFIERS' => ''
        }
      end

      it 'does not calls any notifiers' do
        klasses.each do |klass|
          expect(klass).to_not receive(:call).with(run: run)
        end

        notifiers.call(run)
      end
    end

    context 'without bogus notifers configured' do
      let(:env_vars) do
        {
          'CANARY_NOTIFIERS' => 'bizzle'
        }
      end

      it 'raises a name error' do
        expect { notifiers.call(run) }.to raise_error(
          NameError,
          /uninitialized constant Canary::Notifiers::Bizzle/
        )
      end
    end
  end
end
