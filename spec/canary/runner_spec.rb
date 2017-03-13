require 'spec_helper'

RSpec.describe Canary::Runner do
  include_context 'stub rspec formatter'
  include_context 'stub notifiers'

  let(:path) { 'spec' }
  subject(:runner) { described_class.new(path) }

  describe '.call' do
    context 'passing run' do
      include_context 'passing output hash'

      it 'returns a run' do
        expect(runner.call).to be_an_instance_of(Canary::Run)
      end

      it 'calls the notifier service' do
        expect(Canary::Notifiers).to receive(:call)
        runner.call
      end
    end
  end
end
