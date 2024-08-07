module Calleable
    def call(email, password)
      new(email, password).call
    end
  end