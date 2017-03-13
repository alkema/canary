require 'spec_helper'

RSpec.describe Canary do
  subject(:canary) { described_class }

  let(:name) { 'google' }
  let(:url) { 'https://google.com' }
  let(:cluster) { 'awesome' }

  let(:env_vars) do
    {
      'CANARY_GOOGLE_CLUSTER' => cluster,
      'CANARY_GOOGLE_URL' => url
    }
  end
  include_context 'stub env'
  include_context 'stub vendor dir'

  describe '.app_names' do
    it 'loads app names by from spec directory' do
      expect(canary.app_names).to include(name)
    end
  end

  describe '.apps' do
    it 'lists app objects' do
      expect(canary.apps).to include(have_attributes(
                                       name: name,
                                       url: url,
                                       cluster: cluster
      ))
    end
  end

  describe 'VENDOR_SPEC_PATH_REGEX' do
    let(:path) do
      (Canary::VENDOR_SPEC_PATH + 'google/features/sign_in_spec.rb').to_s
    end

    it 'matches spec path' do
      expect(Canary::VENDOR_SPEC_PATH_REGEX.match(path)[1]).to eq('google')
    end
  end
end
