def invoke_on_each(*args, &block)
  args.each { |arg| yield arg }
end


invoke_on_each(1, 2, 3, 4) do |number|
  puts number ** 2
end
