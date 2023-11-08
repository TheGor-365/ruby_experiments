class Plane
  def call(lat, lon, *attributes)
    points = []

    lat = { lat: 50 }
    lon = { lon: 87 }

    attributes << lat
    attributes << lon

    points << lat
    points << lon

    points.join(' ')
  end
end



class Navigator
  attr_accessor :route_strategy, :type

  def initialize(type = :plane)
    @type = type
  end

  def build_route(lat, lon)
    points = []
    points = route_strategy.new.call(lat, lon)
    return points
  end
end



navigator = Navigator.new
navigator.route_strategy = Plane


pp navigator; puts
pp navigator.build_route(:lat, :lon)
pp navigator.type
