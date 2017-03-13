RSpec.shared_context 'stub env' do
  around do |example|
    ClimateControl.modify env_vars do
      example.run
    end
  end
end
