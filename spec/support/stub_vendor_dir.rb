RSpec.shared_context 'stub vendor dir' do
  let(:google_path) { Pathname.new('./vendor/google') }
  let(:bing_path) { Pathname.new('./vendor/bing') }
  let(:file_path) { Pathname.new('./vendor/README.md') }

  before do
    [google_path, bing_path].each do |path|
      allow(path).to receive(:directory?).and_return(true)
    end

    allow(Canary::VENDOR_SPEC_PATH).to receive(:children).and_return(
      [google_path, bing_path, file_path]
    )
  end
end
