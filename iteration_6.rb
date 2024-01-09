module Enumerable
  def kollect(*new_ary)
    self.each do |item|
      new_ary.push yield(item)
    end
  end
end


names = %w[ leigh marian ]

pp names.kollect(&:upcase)
pp names.kollect { |name| name.upcase! }; puts





class FibonacciNumbers
  NUMBERS = [ 1, 1, 2, 3, 5, 8, 13, 21, 34, 55 ]

	def each
  end
end

fibonacci_numbers = FibonacciNumbers.new

result = fibonacci_numbers.each do |fibonacci_number|
  "A Fibonacci number multiplied by 10: #{fibonacci_number * 10}"
end

pp result; puts





class FibonacciNumbers
  NUMS = [ 1, 1, 2, 3, 5, 8, 13, 21, 34, 55 ]

  def select(*filtered_result, &filtering_condition_block)
    NUMS.each do |number|
      filtered_result << number if filtering_condition_block.call(number)
    end; filtered_result
  end
end

nums = FibonacciNumbers.new

result = nums.select do |number|
  number % 2 == 0
end.each do |even_number|
  even_number
end

pp result
