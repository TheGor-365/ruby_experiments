def foo(arguments, &block)
  pp arguments
  block.call(arguments.reverse)
end


message = foo 'arguments' do |m|
  pp m
  pp m
end; puts


pp message
