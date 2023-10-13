def sum *args
  pp yield(args.sum)
end

sum(1, 2) do |param|
  param.to_s
end
