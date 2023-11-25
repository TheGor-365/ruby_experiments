def foo(arg1)
  block_given? ? yield(arg1) : (pp 'you have to provide a block')
end


arg1 = ' arg1'

foo arg1; puts


foo arg1 do |message|
  pp message
  pp message + arg1
end
