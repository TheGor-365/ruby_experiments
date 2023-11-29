def foo(arguments, &block)
  block.call(arguments.reverse)
end


arguments = ' arguments'

message = foo arguments do |m|
  pp m + arguments
  pp m
  pp m + ' 5'
end; puts


pp message
