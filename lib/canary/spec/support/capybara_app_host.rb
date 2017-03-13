RSpec.shared_context 'capybara app host' do
  before do |example|
    Capybara.app_host = Canary.config.fetch("#{example.metadata[:app]}_url")
  end
end
