RSpec.shared_context 'passing output hash' do
  let(:examples) do
    [
      {
        'description' => 'signs in',
        'full_description' => 'user signs in',
        'status' => 'passed',
        'file_path' => './spec/google/features/sign_in_spec.rb',
        'line_number' => 9,
        'run_time' => 11.545272,
        'pending_message' => nil
      },
      {
        'description' => 'signs out',
        'full_description' => 'user signs out',
        'status' => 'passed',
        'file_path' => './spec/google/features/sign_out_spec.rb',
        'line_number' => 9,
        'run_time' => 12.234245,
        'pending_message' => nil
      }
    ]
  end

  let(:output_hash) do
    {
      'version' => '3.5.4',
      'examples' => examples,
      'summary' => {
        'duration' => 23.779517,
        'example_count' => 2,
        'failure_count' => 0,
        'pending_count' => 0
      },
      'summary_line' => '1 example, 0 failures'
    }
  end
end
