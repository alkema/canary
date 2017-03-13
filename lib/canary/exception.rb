module Canary

  # Simple data class to represent an rspec exception based on rspec's `output_hash`
  class Exception

    include Virtus.model

    attribute :message, String
    attribute :backtrace, Array[String]

  end

end
