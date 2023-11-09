def foo(arg1)
  yield(arg1.reverse)
end

message = foo 'arg1' do |m|
  m
  m
end

puts message
