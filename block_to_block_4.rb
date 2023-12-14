def awesome_method(hash)
  @result = []

  hash.each do |key, value|
    @result << yield(key)
    @result << yield(value)
    @result << yield({key => value})
  end
  @result
end


hash = {
  a: 'apple',
  b: 'banana',
  c: 'cookie'
}



params = awesome_method hash do |item|
  pp item
  pp item
end; puts



pp params
