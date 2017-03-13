RSpec.shared_context 'stub app names' do
  before do
    allow(Canary).to receive(:app_names).and_return(%w(google))
  end
end
