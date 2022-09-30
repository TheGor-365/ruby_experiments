define_method("example") do |fixed, default = {}|
  puts fixed
  puts default
end

example('Hello', key: :value)
example('Hello')
puts

define_method(:my_method) do |foo, bar|
  bar ||= {}
  puts foo
  puts bar
end

my_method('Hello', key: :value)
my_method('Hello', nil)
