def awesome_method(options, *result)
  options.each do |key, value|
    result << yield(value) if key.length <= 3
  end; result
end


options = {
  aa:    'apple',
  bbb:   'banana',
  cccc:  'cookie',
  color: 'white'
}



params = awesome_method options do |item|
  item
  item
end



pp params
