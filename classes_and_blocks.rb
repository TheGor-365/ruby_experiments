class Car
  def big_car
    "This is the big car"
  end

  def small_car
    "This is the small car"
  end

  def doors
    "This car have a five doors" if self.big_car
  end
end

p big_car = Car.new
puts
p big_car.big_car
puts
p small_car = Car.new
puts
p small_car.small_car
puts
p big_car.doors
p small_car.doors
puts
puts


def outer(&block)
  if true
    wrapper = lambda {
      p 'Do something crazy in this wrapper'
      block.call # original block
    }
    inner(&wrapper)
  else
    inner(&passed_block)
  end
end

def inner(&block)
  p 'inner called'
  yield
end

outer do
  p 'inside block'
  sleep 1
end
