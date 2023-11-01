def my_method
  value = yield
  puts "value is: #{value}"
end

my_method do
  2
end
