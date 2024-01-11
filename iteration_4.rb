class FormBuilder
  def self.form_for(params, *form)
    form << yield(params)
  end
end

public

def input(key, *input)
  result = ''

  FormBuilder.form_for self do |f|
    f.each do |item|
      result = key if self.include?(key)
    end
    result
  end
end



params = %w[ one two three four ]

result = FormBuilder.form_for params do |f|
  f.input 'one'
  f.input 'two'
end

pp result
