def foo(arg1)
  yield(arg1.reverse)
end


arg1 = ' arg1'

message = foo arg1 do |m|
  pp m + arg1
  pp m
end

message
