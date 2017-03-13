RSpec.shared_context 'failing output hash' do
  # rubocop:disable Metrics/LineLength
  let(:backtrace) do
    [
      "/Users/bob/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rspec-support-3.5.0/lib/rspec/support.rb:87:in `block in <module:Support>'",
      "/Users/bob/src/canary/bin/canary:6:in `<main>'"
    ]
  end

  let(:examples) do
    [
      {
        description: 'signs in',
        full_description: 'user signs in',
        status: 'failed',
        file_path: './spec/google/features/sign_in_spec.rb',
        line_number: 9,
        run_time: 70.988129,
        pending_message: nil,
        exception: {
          class: 'RSpec::Expectations::ExpectationNotMetError',
          message: 'expected to find text "Pendingx" in "Bookings Pending 62 Waitlist 15"',
          backtrace: backtrace
        }
      }
    ]
  end

  let(:output_hash) do
    {
      version: '3.5.4',
      examples: examples,
      summary: {
        duration: 70.988751,
        example_count: 1,
        failure_count: 1,
        pending_count: 0
      },
      summary_line: '1 example, 1 failure'
    }
  end
end
