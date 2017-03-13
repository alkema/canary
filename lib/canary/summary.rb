module Canary

  # Simple data class to represent an rspec summary based on rspec's `output_hash`
  class Summary

    include Virtus.model

    attribute :duration, Float
    attribute :example_count, Integer
    attribute :failure_count, Integer
    attribute :pending_count, Integer

  end

end
