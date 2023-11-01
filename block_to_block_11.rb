def foo(arg1)
  block_given? ? yield(arg1) : (puts 'you have to provide a block')
end

foo 'arg1' do |message|
  puts message
end
