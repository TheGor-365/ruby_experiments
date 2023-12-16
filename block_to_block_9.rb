def foo(arguments, &block)
  @result = []
  arguments.each do |argument|
    @result << block.call(argument)
  end
  @result
end


arguments = ['arguments', 's', :something, { key: :value }]

message = foo arguments do |m|
  pp m
  pp m
  pp m
end; puts


pp message
