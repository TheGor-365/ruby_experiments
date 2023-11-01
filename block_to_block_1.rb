def pick_random_numbers(min, max, limit)
  limit.times { yield min + rand(max + 1) }
end

def lottery_style_numbers(&block)
  pick_random_numbers(1, 49, 6, &block)
end


lottery_style_numbers do |number|
  puts "Lucky umber: #{number}"
end
