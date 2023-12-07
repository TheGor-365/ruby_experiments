def awesome_method
  hash = {
    a: 'apple',
    b: 'banana',
    c: 'cookie'
  }

  hash.each do |key, value|
    yield key, value
  end
end



params = awesome_method do |hash|
  pp hash
  pp hash
end

pp params
