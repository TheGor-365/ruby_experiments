def pick_random_numbers(min, max, limit)
  limit.times do
    yield min + rand(max)
  end
end

def lottery_style_numbers(&block)
  pick_random_numbers(1, 49, 6, &block)
end


lottery_style_numbers do |number|
  pp number + 1000
end
