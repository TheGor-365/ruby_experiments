class FormBuilder
  def self.form_for(array, *form)
    yield(array)
  end
end

public

def input(param, *input)
  pp input << param
end


array = %w[ one two three four ]

result = FormBuilder.form_for array do |f|
  f.input 'one'
  f.input 'one'
  f.input 'two'
end

pp result
