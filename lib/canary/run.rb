module Canary

  # Simple data class to represent an rspec run based on rspec's `output_hash`
  class Run

    include Virtus.model

    attribute :examples, Array[Canary::Example]
    attribute :summary, Canary::Summary
    attribute :summary_line, String

    def pass_count
      passed_examples.length
    end

    def fail_count
      failed_examples.length
    end

    def failed?
      fail_count.positive?
    end

    def passed_examples
      examples.select(&:passed?)
    end

    def failed_examples
      examples.select(&:failed?)
    end

  end

end
