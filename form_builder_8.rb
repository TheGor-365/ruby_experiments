class Plane
  def initialize
  end

  def call a, b, *attributes
    points = []

    a = { lat: 50 }
    b = { lon: 87 }

    attributes << a
    attributes << b

    points << a
    points << b

    points.join(' ')
  end
end



class Navigator
  attr_accessor :route_strategy, :type

  def initialize type=:plane
    @type = type
  end

  def build_route a, b
    points = []
    points = route_strategy.new.call a, b

    return points
  end
end

pp navigator = Navigator.new
puts

pp navigator.route_strategy = Plane
puts

pp navigator.build_route :a, :b
pp navigator.type
