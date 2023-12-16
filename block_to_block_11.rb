def foo(args)
  result = []
  args.each do |arg|
    result << (block_given? ? yield(arg) : ('you have to provide a block'))
  end
  result
end


arg = [:some, 'arg']


res = foo arg do |message|
  pp message
  pp message
end; puts


pp res
