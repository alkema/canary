RSpec.shared_context 'stub rspec formatter' do
  before do
    allow(Canary::RspecFormatter).to receive(:run)
    allow(Canary::RspecFormatter).to receive(:formatter).and_return(nil)
    allow(Canary::RspecFormatter).to receive(:output_hash).and_return(output_hash)
  end
end
