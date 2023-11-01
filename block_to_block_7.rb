def mad_libs
  yield('cool', 'beans', 'burrito')
end


result = mad_libs do |adjective, noun, burrito|
  "#{adjective} #{noun} #{burrito}"
end

puts result
