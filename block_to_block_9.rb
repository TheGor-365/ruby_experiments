def iterator(arguments, *result,  &block)
  arguments.each do |argument|
    result << block.call(argument)
  end; result
end


arguments = ['arguments', 's', :something, { key: :value }]

message = iterator arguments do |m|
  m
  m
end


pp message
