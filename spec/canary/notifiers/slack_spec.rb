require 'spec_helper'

RSpec.describe Canary::Notifiers::Slack do
  include_context 'stub rspec formatter'
  include_context 'stub app names'

  let(:run) { Canary::Run.new(output_hash) }
  let(:client) { double }
  subject(:slack_notifier) { described_class.new(run: run, client: client) }

  describe '.call' do
    context 'passing run' do
      include_context 'passing output hash'

      it ' does not call the notifier service' do
        expect(client).to_not receive(:ping)
        slack_notifier.call
      end
    end

    context 'failing run' do
      include_context 'failing output hash'

      it 'calls the notifier service' do
        expect(client).to receive(:ping)
        slack_notifier.call
      end
    end
  end
end
