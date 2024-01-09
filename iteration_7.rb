class FormBuilder
  def form_for(params, *form)
    params.each do |item|
      form << item if yield(item)
    end; form
  end
end

params = %w[ first_field second_field third_field fourth_field ]

nums = FormBuilder.new

result = nums.form_for params do |item|
  item[0] == 't' || item[0] == 'f'
end.each do |choosed_item|
  choosed_item
end

pp result; puts







class FormBuilder
  def self.form_for(params, *form)
    params.each do |key, value|
      form << value if yield(key)
    end; form
  end
end

params = {
  first:  'one',
  second: 'two',
  third:  'three',
  fourth: 'four'
}

result = FormBuilder.form_for params do |key, value|
  key[0] == 'f' || key[0] == 't'
end.each do |key, value|
  key
end

pp result; puts








class FormBuilder
  def self.form_for(params, *form)
    # params.each do |key, value|
    #   form << value if yield(key)
    # end; form
    yield(params)
  end
end

public

def input(param, *input)
  FormBuilder.form_for self do |f|
    input << f.fetch(param)
  end
end

params = {
  first:  'one',
  second: 'two',
  third:  'three',
  fourth: 'four',
  five:   'five'
}

result = FormBuilder.form_for params do |f|
  f.input :first
  f.input :first
  f.input :third
end

pp result; puts







class FibonacciNumbers
	NUMBERS = [ 1, 1, 2, 3, 5, 8, 13, 21, 34, 55 ]
end

numbers = FibonacciNumbers.new

if numbers.respond_to?(:map)
  squares = numbers.map { |number| number * number }
	pp "The squares of the fibonacci numbers are #{squares}"
else
  pp 'I will reveal the squares to you once you pass the tests'
end
