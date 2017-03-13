require 'spec_helper'

RSpec.describe Canary::Run do
  subject(:run) { described_class.new(output_hash) }

  context 'passing run' do
    include_context 'passing output hash'
    let(:full_description) { 'user signs in' }

    let(:status) { 'passed' }

    it 'has a correct pass count' do
      expect(run.pass_count).to eq(2)
    end

    it 'has a correct fail count' do
      expect(run.fail_count).to eq(0)
    end

    it 'is not failed' do
      expect(run.failed?).to_not be_truthy
    end

    it 'lists passed examples' do
      expect(run.passed_examples).to include(have_attributes(status: status))
    end

    it 'lists no failed examples' do
      expect(run.failed_examples).to be_empty
    end
  end

  context 'failing run' do
    include_context 'failing output hash'

    let(:status) { 'failed' }

    it 'has a correct pass count' do
      expect(run.pass_count).to eq(0)
    end

    it 'has a correct fail count' do
      expect(run.fail_count).to eq(1)
    end

    it 'is failed' do
      expect(run.failed?).to be_truthy
    end

    it 'lists failed examples' do
      expect(run.failed_examples).to include(have_attributes(status: status))
    end

    it 'lists no passed examples' do
      expect(run.passed_examples).to be_empty
    end
  end
end
