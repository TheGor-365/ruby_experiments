def foo(&my_block)
  my_block.call('hi')
end

m = foo do |message|
  message
  message
end


puts m
