class Car
  def big_car
    'big car'
  end

  def small_car
    'small car'
  end

  def doors
    'five doors' if self.big_car
  end
end



big_car = Car.new

pp big_car.big_car


small_car = Car.new

pp small_car.small_car
pp big_car.doors
pp small_car.doors; puts



def outer(&block)
  if true
    wrapper = lambda do
      pp 'Do something crazy in this wrapper'
      block.call
    end
    inner(&wrapper)
  else
    inner(&passed_block)
  end
end


def inner(&block)
  pp 'inner called'
  yield
end

outer do
  pp 'inside block'
  sleep 0.03
end
