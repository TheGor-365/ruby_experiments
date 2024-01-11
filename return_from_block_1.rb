def thing(*arguments, &block)
  define_method(:__thing, &block)
  arguments << "value=#{__thing}"
end

result = thing do
  return 6 * 7
end

pp result; puts
