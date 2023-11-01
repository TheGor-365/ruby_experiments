def awesome_method
  hash = {a: 'apple', b: 'banana', c: 'cookie'}

  hash.each do |key, value|
    yield key, value
  end
end



params = awesome_method do |key, value|
  "#{key}: #{value}"
end

pp params
