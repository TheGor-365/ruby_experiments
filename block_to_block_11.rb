def show_items(arguments, *result)
  arguments.each do |argument|
    result << (block_given? ? yield(argument) : ('you have to provide a block')) if argument.kind_of?(Symbol)
  end; result
end

arguments = [:some, :some_else, 'argument']

result = show_items arguments do |message|
  message
  message
end

pp result
