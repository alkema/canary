RSpec.shared_context 'stub notifiers' do
  before do
    allow(Canary::Notifiers).to receive(:call)
  end
end
