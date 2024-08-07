module Calleable
  def call(*args, **kargs)
    new(*args, **kargs).call
  end

  def call!(*args, **kargs)
    new(*args, **kargs).call!
  end
end