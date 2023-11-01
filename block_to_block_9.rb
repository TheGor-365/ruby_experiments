def foo(arg1, &block)
  puts "arg1 is: #{arg1.inspect}"
  block.call(arg1.reverse)
end


m = foo 'arg1' do |message|
  message
  message
end

puts m
