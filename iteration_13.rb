class FormBuilder
  def self.form_for(params, *form)
    yield(params)
  end
end

public

def input(param, *input)
  FormBuilder.form_for self do |f|
    f.each_with_object({}) do |(name, value), hash|
      input << { name => value }.fetch(name) if name == param
    end
  end
  pp param
  input
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
