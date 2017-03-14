RSpec.describe 'google', type: :feature do
  include_context 'capybara app host'

  let(:keyword) { Canary.config.google_keyword } # Set with ENV['CANARY_GOOGLE_KEYWORD']

  it 'finds keyword' do
    visit '/'

    fill_in 'q', with: keyword
    click_button('Google Search')

    expect(page.find('body')).to have_content(keyword) # Expect this to pass
    expect(page.find('body')).to have_content('Bogus') # Expect this to fail, and therefore send a Slack attachment to to Slack
  end
end
