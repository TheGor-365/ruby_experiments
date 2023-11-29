def foo(&my_block)
  my_block.call({hi: 'hi'})
end

message = foo do |m|
  pp m
  pp m
end; puts


puts message
