def foo(arg1)
  yield(arg1.reverse)
end

m = foo 'arg1' do |message|
  message
  message
end

puts m
