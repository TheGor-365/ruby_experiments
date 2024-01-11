class TryBlock
  $escape = []

  def initialize(proc)
    @exception = callcc do |cont|
      $escape.push cont
      @result = proc.call
      cont nil
    end
  end

  def except(ex_type)
    if @exception and @exception.instanceof? ex_type
      yield @exception
      @exception = nil
    end
    return self
  end

  def finally
    yield
    try_end
  end

  def try_end
    do_raise @exception if @exception
    return @result
  end
end


def my_try(&block)
  TryBlock.new block
end

def do_raise(exception)
  if $escape
    $escape.pop.call exception
  else
    exit(1)
  end
end







module HeyModule
  def self.say_hi(name)
    pp "Hey #{name}"
    yield
    pp 'Exiting the method'
  end

  say_hi 'Jack' do
    pp 'Good Day'
  end
end
